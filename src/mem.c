#include "../include/graphics.h"
#include "../include/core.h"
#include "../include/mem.h"

#define WRAM_ALLOCATOR (wram_allocator *)0x02000000
#define E_ALLOC_BASE (void *) 0x02000100
#define E_ALLOC_BLOCK_TRACK (block *) 0x02030000
#define E_FREE_BLOCK_TRACK (block *) 0x02037800
#define I_ALLOC_BLOCK_TRACK (block *) 0x0203F000
#define I_FREE_BLOCK_TRACK (block *) 0x0203F800
#define E_WRAM_CEIL (block *) 0x0203FFFF
#define BLOCK_SIZE sizeof(block)

#define I_ALLOC_BASE (void *) 0x03000000
#define I_ALLOC_CEIL 0x03007D00


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
    char* alloc_ceiling;
    block* free_ceiling;
} block_allocator;

typedef struct wram_allocator_t {
    block_allocator ewram_allocator;
    block_allocator iwram_allocator;
    uint32 debug_value;
} wram_allocator;

static inline wram_allocator* wram_allocator_ptr() {
    return WRAM_ALLOCATOR;
}

// must be called once at startup
void mem_init() {
    wram_allocator* w_a = wram_allocator_ptr();

    w_a->ewram_allocator.alloc_block_track = E_ALLOC_BLOCK_TRACK;
    w_a->ewram_allocator.free_block_track = E_FREE_BLOCK_TRACK;
    w_a->ewram_allocator.next_alloc_location = E_ALLOC_BASE;
    w_a->ewram_allocator.num_allocs = 0;
    w_a->ewram_allocator.num_free = 0;
    w_a->ewram_allocator.free_ceiling = (block*)I_ALLOC_BLOCK_TRACK;
    w_a->ewram_allocator.alloc_ceiling = (char*)E_ALLOC_BLOCK_TRACK;

    w_a->iwram_allocator.alloc_block_track = I_ALLOC_BLOCK_TRACK;
    w_a->iwram_allocator.free_block_track = I_FREE_BLOCK_TRACK;
    w_a->iwram_allocator.next_alloc_location = I_ALLOC_BASE;
    w_a->iwram_allocator.num_allocs = 0;
    w_a->iwram_allocator.num_free = 0;
    w_a->iwram_allocator.free_ceiling = (block*)E_WRAM_CEIL;
    w_a->iwram_allocator.alloc_ceiling = (char*)I_ALLOC_CEIL;
}

void _write_debug_value(uint32 val) {
    wram_allocator_ptr()->debug_value = val;
}

uint32 _read_debug_value() {
    return wram_allocator_ptr()->debug_value;
}

static inline uint32 _get_num_allocs(block_allocator* allocator) {
    return allocator->num_allocs;
}

static inline void _set_num_allocs(block_allocator* allocator, uint32 allocs) {
    allocator->num_allocs = allocs;
}

static inline uint32 _get_num_free(block_allocator* allocator) {
    return allocator->num_free;
}

static inline void _set_num_free(block_allocator* allocator, uint32 free) {
    allocator->num_free = free;
}

static inline void* _get_alloc_location(block_allocator* allocator) {
    return allocator->next_alloc_location;
}

static inline void _set_alloc_location(block_allocator* allocator, void* loc) {
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
    if (new_addr + 1 >= allocator->free_ceiling) {
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

static inline uint32 _word_align(uint32 size) {
    if (size & 0b11) {
        size = (size - (size & 0b11)) + 0b100;
    }
    return size;
}

void* _malloc(block_allocator* allocator, uint32 size) {
    size = _word_align(size);
    _write_debug_value(size);
    uint32 num_free = _get_num_free(allocator);
    void* addr = NULL;
    for (uint32 i = 0; i < num_free; ++i) {
        block* free_block = allocator->free_block_track + i;
        if (free_block->size == size) {
            addr = free_block->location;
            _write_allocated_block(allocator, *free_block);
            _remove_free_block(allocator, i);
            return addr;
        }
        else if (free_block->size > size) {
            addr = free_block->location;
            block new_block;
            new_block.location = addr;
            new_block.size = size;
            _write_allocated_block(allocator, new_block);
            free_block->location = (char*)free_block->location + size;
            free_block->size -= size;
            return addr;
        }
    }

    if ((char*)(allocator->next_alloc_location) + size < allocator->alloc_ceiling) {
        block new_block;
        new_block.location = _get_alloc_location(allocator);
        new_block.size = size;
        _set_alloc_location(allocator, (char*)new_block.location + size);
        _write_allocated_block(allocator, new_block);
        return new_block.location;
    }
    _panic();
    return (void*)NULL;
}

uint32 _free(block_allocator* allocator, void* ptr) {
    for (uint32 i = 0; i < _get_num_allocs(allocator); ++i) {
        block* alloced_block = allocator->alloc_block_track + i;
        if (alloced_block->location == ptr) {
            uint32 block_size = alloced_block->size;
            _write_free_block(allocator, *alloced_block);
            _remove_alloced_block(allocator, i);
            return block_size;
        }
    }
    _panic();
    return 0;
}

void* malloc(uint32 size) {
    return _malloc(&wram_allocator_ptr()->ewram_allocator, size);
}

void* fast_malloc(uint32 size) {
    return _malloc(&wram_allocator_ptr()->iwram_allocator, size);
}

void free(void* ptr) {
    _free(&wram_allocator_ptr()->ewram_allocator, ptr);
}

void fast_free(void* ptr) {
    _free(&wram_allocator_ptr()->iwram_allocator, ptr);
}

void* cache(void* ptr) {
    uint32 ptr_size = _free(&wram_allocator_ptr()->ewram_allocator, ptr);
    char* fast_ptr = _malloc(&wram_allocator_ptr()->iwram_allocator, ptr_size);

    for (uint32 i = 0; i < ptr_size; ++i) {
        *(fast_ptr + i) = *((char*)ptr + i);
    }

    return fast_ptr;
}

void* uncache(void* ptr) {
    uint32 ptr_size = _free(&wram_allocator_ptr()->iwram_allocator, ptr);
    char* slow_ptr = _malloc(&wram_allocator_ptr()->ewram_allocator, ptr_size);

    for (uint32 i = 0; i < ptr_size; ++i) {
        *(slow_ptr + i) = *((char*)ptr + i);
    }

    return slow_ptr;
}
