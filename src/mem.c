#include "../include/graphics.h"
#include "../include/core.h"
#include "../include/mem.h"

#define WRAM_ALLOCATOR (wram_allocator *)0x02000000
#define ALLOC_BASE (void *) 0x02000100
#define ALLOC_BLOCK_TRACK (block *) 0x02030000
#define FREE_BLOCK_TRACK (block *) 0x0203F000
#define WRAM_CEIL (block *) 0x0203FFFF
#define BLOCK_SIZE sizeof(block)

typedef struct block_t {
    void* location;
    uint32 size;
} block;

typedef struct block_allocator_t {
    void* next_alloc_location;
    uint32 num_allocs;
    uint32 num_free;
    block* alloc_block_track;
    block* free_block_track;
    void* ceiling;
} block_allocator;

typedef struct wram_allocator_t {
    block_allocator ewram_allocator;
    uint32 debug_value;
} wram_allocator;

wram_allocator* wram_allocator_ptr() {
    return WRAM_ALLOCATOR;
}

// must be called once at startup
void mem_init() {
    wram_allocator* w_a = wram_allocator_ptr();

    w_a->ewram_allocator.alloc_block_track = ALLOC_BLOCK_TRACK;
    w_a->ewram_allocator.free_block_track = FREE_BLOCK_TRACK;
    w_a->ewram_allocator.next_alloc_location = ALLOC_BASE;
    w_a->ewram_allocator.num_allocs = 0;
    w_a->ewram_allocator.num_free = 0;
    w_a->ewram_allocator.ceiling = WRAM_CEIL;
}

void _write_debug_value(uint32 val) {
    wram_allocator_ptr()->debug_value = val;
}

uint32 _read_debug_value() {
    return wram_allocator_ptr()->debug_value;
}

uint32 _get_num_allocs(block_allocator* allocator) {
    return allocator->num_allocs;
}

void _set_num_allocs(block_allocator* allocator, uint32 allocs) {
    allocator->num_allocs = allocs;
}

uint32 _get_num_free(block_allocator* allocator) {
    return allocator->num_free;
}

void _set_num_free(block_allocator* allocator, uint32 free) {
    allocator->num_free = free;
}

void* _get_alloc_location(block_allocator* allocator) {
    return allocator->next_alloc_location;
}

void _set_alloc_location(block_allocator* allocator, void* loc) {
    allocator->next_alloc_location = loc;
}

void _write_allocated_block(block_allocator* allocator, block alloced) {
    uint32 num_allocs = _get_num_allocs(allocator);
    block* new_addr = allocator->alloc_block_track + num_allocs;
    if (new_addr + 1 >= allocator->free_block_track) {
        _write_debug_value(0xDEAD);
        _panic();
    }
    *new_addr = alloced;
    _set_num_allocs(allocator, num_allocs + 1);
}

void _write_free_block(block_allocator* allocator, block alloced) {
    uint32 num_free = _get_num_free(allocator);
    block* new_addr = allocator->free_block_track + num_free;
    if (new_addr + 1 >= WRAM_CEIL) {
        _write_debug_value(0xC0FF);
        _panic();
    }
    *new_addr = alloced;
    _set_num_free(allocator, num_free + 1);
}

void _remove_free_block(block_allocator* allocator, uint32 free_block_idx) {
    for (uint32 j = free_block_idx; j < (_get_num_free(allocator) - 1); ++j) {
        block* free_block = allocator->free_block_track + j;
        block* next_free_block = free_block + 1;
        *free_block = *next_free_block;
    }
    _set_num_free(allocator, _get_num_free(allocator) - 1);
}

void _remove_alloced_block(block_allocator* allocator, uint32 alloc_block_idx) {
    for (uint32 j = alloc_block_idx; j < (_get_num_allocs(allocator) - 1); ++j) {
        block* alloc_block = allocator->alloc_block_track + j;
        block* next_alloc_block = alloc_block + 1;
        *alloc_block = *next_alloc_block;
    }
    _set_num_allocs(allocator, _get_num_allocs(allocator) - 1);
}

void* malloc(uint32 size) {
    block_allocator* ewram_allocator = &(wram_allocator_ptr()->ewram_allocator);
    if (size & 0b11) {
        size = (size - (size & 0b11)) + 0b100;
    }
    _write_debug_value(size);
    uint32 num_free = _get_num_free(ewram_allocator);
    void* addr = NULL;
    for (uint32 i = 0; i < num_free; ++i) {
        block* free_block = ewram_allocator->free_block_track + i;
        if (free_block->size == size) {
            addr = free_block->location;
            _write_allocated_block(ewram_allocator, *free_block);
            _remove_free_block(ewram_allocator, i);
            return addr;
        }
        else if (free_block->size > size) {
            addr = free_block->location;
            block new_block;
            new_block.location = addr;
            new_block.size = size;
            _write_allocated_block(ewram_allocator, new_block);
            free_block->location = (char*)free_block->location + size;
            free_block->size -= size;
            return addr;
        }
    }

    if ((char*)(ewram_allocator->next_alloc_location) + size < (char*)(ewram_allocator->alloc_block_track)) {
        block new_block;
        new_block.location = _get_alloc_location(ewram_allocator);
        new_block.size = size;
        _set_alloc_location(ewram_allocator, (char*)new_block.location + size);
        _write_allocated_block(ewram_allocator, new_block);
        return new_block.location;
    }
    _panic();
    return (void*)NULL;
}

void free(void* ptr) {
    block_allocator* ewram_allocator = &(wram_allocator_ptr()->ewram_allocator);
    for (uint32 i = 0; i < _get_num_allocs(ewram_allocator); ++i) {
        block* alloced_block = ewram_allocator->alloc_block_track + i;
        if (alloced_block->location == ptr) {
            _write_free_block(ewram_allocator, *alloced_block);
            _remove_alloced_block(ewram_allocator, i);
            return;
        }
    }
    _panic();
}
