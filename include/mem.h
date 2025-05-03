#define NULL 0

void mem_init();
void* malloc(uint32 size);
void free(void* ptr);
void _write_debug_value(uint32 val);