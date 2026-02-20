#define NULL 0

// must be called at startup
void mem_init();

// malloc from external wram (256k, slow)
void* malloc(uint32 size);

// malloc from internal wram (32k, fast)
void* fast_malloc(uint32 size);

// free external wram pointer
void free(void* ptr);

// free internal wram pointer
void fast_free(void* ptr);

// move a pointer from ewram to iwram
void* cache(void* ptr);

// move a pointer from iwram to ewram
void* uncache(void* ptr);

void _write_debug_value(uint32 val);
uint32 _read_debug_value();
