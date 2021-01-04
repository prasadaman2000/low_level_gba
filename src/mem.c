#include "../include/graphics.h"
#include "../include/core.h"
#include "../include/mem.h"

#define MEM_BASE (void *) 0x02000000
#define BLOCK_TRACK_BASE (void *) 0x0203F000
#define BLOCK_TRACK_CEILING (void *) 0x203FFFF
#define MAX_NUM_BLOCKS 400

// struct for free block information 
typedef struct mem_block {
    void * loc;
    int size;
} mem_block;

// structure that contains an array of mem_blocks
// implemented this way to ensure that the array starts at BLOCK_TRACK_BASE
typedef struct block_arr_t{
    mem_block block_arr[MAX_NUM_BLOCKS];
} block_arr_td;

//variables to be used across malloc and free
int size_allocated;
int mem_block_size;
int num_alloced_blocks;
block_arr_td * block_arr = BLOCK_TRACK_BASE;

// must be called a single time by lowest level software
void mem_init(){
    // reset all blocks
    for(int i = 0; i < MAX_NUM_BLOCKS; i++){
        block_arr -> block_arr[i].loc = NULL;
    }

    // mark first block as free
    block_arr -> block_arr[0].size = 0x0003F000;
    block_arr -> block_arr[0].loc = MEM_BASE;

    //variables tracking allocated space
    size_allocated = 0;
    num_alloced_blocks = 0;
}

/*
    returns address of allocated block of specified size
    returns NULL on failure
*/
void * malloc(uint32 size_to_alloc){
    mem_block * curr;

    //bitmask lower 2 bits of size to allocate to get remainder: faster than size % 4
    uint32 remainder_to_word = 4 - (size_to_alloc & 3);

    // if there are still bytes to get to the next word, add to size_to_alloc
    // == 4 represents remainder 4, which is equivalent to remainder 0
    if(!(remainder_to_word == 4)){
        size_to_alloc += remainder_to_word;
    }

    /*
        size is calculated as the amount requested + the number of bytes
        needed to store the allocated size for freeing
    */
    uint32 size = size_to_alloc + sizeof(uint32);

    for(int i = 0; i < MAX_NUM_BLOCKS; i++){
        // draw a pixel every time a new block is explored
        draw_pixel(i % SCREEN_H, 2 * i / SCREEN_H, 0xFFFF);

        // get address of i-th block
        curr = &(block_arr -> block_arr[i]);

        if(curr -> size > size){
            /*
                if the current block has a size greater than
                the requested size, then adjust the block accordingly
            */
            void * alloced_addr = curr -> loc;

            //update block properties
            curr -> loc = (char *)curr -> loc + size;
            curr -> size -= size;

            // add the size of the allocated block to the beginning (note the * at the beginning)
            *((uint32 *)alloced_addr) = size_to_alloc;

            // return the offset address. cast to char * to get rid of warning
            return (char *)alloced_addr + sizeof(uint32);
        } else if(curr -> size == size){
            //if the current block contains just enough bytes, remove the current block
            void * allocated_addr = curr -> loc;
            
            // shift all blocks left and set last to invalid
            int j = 0;
            for(j = i; j < MAX_NUM_BLOCKS - 1; j++){
                block_arr -> block_arr[j] = block_arr -> block_arr[j + 1];
            }
            
            block_arr -> block_arr[j].loc = NULL;
            block_arr -> block_arr[j].size = 0;

            // add the size of the allocated block to the beginning
            *((uint32 *)allocated_addr) = size_to_alloc;

            // return the offset address. cast to char * to get rid of warning
            return (char *)allocated_addr + sizeof(uint32);
        }
    }
    return NULL;
    // return (void *)1;
}

/*
    releases the mem_block from consideration if exists
    does nothing otherwise
    //TODO write free()
*/
void free(void * ptr){
    //subtract sizeof(uint32) to account for size of allocated block
    void * alloc_begin = (char *)ptr - sizeof(uint32);

    //get size of allocated block for futher calculations
    uint32 alloced_size = *((uint32 *)alloc_begin);


    void * block_end = (char *)alloc_begin + alloced_size;

    // find block of interest
    uint16 block_idx;
    for(block_idx = 0; block_idx < MAX_NUM_BLOCKS; block_idx++){
        mem_block * curr_m_b = &(block_arr -> block_arr[block_idx]);

        if(block_end == curr_m_b -> loc){
            
        }
    }
}