#include "../include/graphics.h"
#include "../include/core.h"
#include "../include/mem.h"

#define NEXT_ALLOC_LOCATION (void **) 0x02000000
#define NUM_ALLOCS (uint32 *) 0x02000004
#define NUM_FREE (uint32 *) 0x02000008
#define DEBUG_LOCATION (uint32 *) 0x0200000C
#define ALLOC_BASE (void *) 0x02000010
#define ALLOC_BLOCK_TRACK (block *) 0x02030000
#define FREE_BLOCK_TRACK (block *) 0x0203F000
#define BLOCK_SIZE sizeof(block)

typedef struct block_t {
    void* location;
    uint32 size;
} block;

void _panic() {
    while (1) {
        fill_color(GREEN);
        fill_color(RED);
    }
}

void _write_debug_value(uint32 val) {
    *DEBUG_LOCATION = val;
}

uint32 _get_num_allocs() {
    return *NUM_ALLOCS;
}

void _set_num_allocs(uint32 allocs) {
    *NUM_ALLOCS = allocs;
}

uint32 _get_num_free() {
    return *NUM_FREE;
}

void _set_num_free(uint32 free_) {
    *NUM_FREE = free_;
}

void* _get_alloc_location() {
    return *(void**)NEXT_ALLOC_LOCATION;
}

void _set_alloc_location(void* loc) {
    *(void**)NEXT_ALLOC_LOCATION = loc;
}

void _write_allocated_block(block alloced) {
    uint32 num_allocs = _get_num_allocs();
    *((ALLOC_BLOCK_TRACK)+(num_allocs * BLOCK_SIZE)) = alloced;
    _set_num_allocs(num_allocs + 1);
}

void _write_free_block(block alloced) {
    uint32 num_free = _get_num_free();
    *(FREE_BLOCK_TRACK + (num_free * BLOCK_SIZE)) = alloced;
    _set_num_free(num_free + 1);
}

void _remove_free_block(uint32 free_block_idx) {
    for (uint32 j = free_block_idx; j < (_get_num_free() - 1); ++j) {
        block* free_block = FREE_BLOCK_TRACK + j * BLOCK_SIZE;
        block* next_free_block = free_block + BLOCK_SIZE;
        *free_block = *next_free_block;
    }
    _set_num_free(_get_num_free() - 1);
}

void _remove_alloced_block(uint32 alloc_block_idx) {
    for (uint32 j = alloc_block_idx; j < (_get_num_allocs() - 1); ++j) {
        block* alloc_block = ALLOC_BLOCK_TRACK + j * BLOCK_SIZE;
        block* next_alloc_block = alloc_block + BLOCK_SIZE;
        *alloc_block = *next_alloc_block;
    }
    _set_num_allocs(_get_num_allocs() - 1);
}

// must be called a single time at system startup
void mem_init() {
    _set_alloc_location(ALLOC_BASE);
    _set_num_allocs(0);
    _set_num_free(0);
}

void* malloc(uint32 size) {
    uint32 num_free = _get_num_free();
    void* addr = NULL;
    for (uint32 i = 0; i < num_free; ++i) {
        block* free_block = FREE_BLOCK_TRACK + i * BLOCK_SIZE;
        if (free_block->size == size) {
            addr = free_block->location;
            _write_allocated_block(*free_block);
            _remove_free_block(i);
            return addr;
        }
    }

    if ((char*)NEXT_ALLOC_LOCATION + size < (char*)ALLOC_BLOCK_TRACK) {
        block new_block;
        new_block.location = _get_alloc_location();
        new_block.size = size;
        _set_alloc_location((char*)new_block.location + size);
        _write_allocated_block(new_block);
        return new_block.location;
    }
    _panic();
    return (void*)NULL;
}

void free(void* ptr) {
    for (uint32 i = 0; i < _get_num_allocs(); ++i) {
        block* alloced_block = ALLOC_BLOCK_TRACK + (i * BLOCK_SIZE);
        if (alloced_block->location == ptr) {
            _write_free_block(*alloced_block);
            _remove_alloced_block(i);
            return;
        }
    }
    _panic();
}