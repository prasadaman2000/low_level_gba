#include "../include/graphics.h"
#include "../include/core.h"
#include "../include/mem.h"
#include "../include/timint.h"

int main() {
    graphics_init();
    mem_init();

    char* x = malloc(26);
    free(x);

    x = malloc(26);

    fill_color(WHITE);

    while (1);
}