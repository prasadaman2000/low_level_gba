#include "../include/graphics.h"
#include "../include/core.h"
#include "../include/mem.h"
#include "../include/timint.h"
#include "../include/matrix.h"

void _panic1() {
    while (1) {
        fill_color(RED);
        fill_color(GREEN);
    }
}

int main() {
    graphics_init();
    mem_init();
    // interrupt_init();

    // uint8 rows = 2;
    // uint8 cols = 2;

    // matrix* m1 = new_matrix(rows, cols);
    // for (uint8 r = 0; r < rows; ++r) {
    //     for (uint8 c = 0; c < cols; ++c) {
    //         if (r == c) {
    //             matrix_write(m1, r, c, 100);
    //         }
    //     }
    // }

    // matrix* m4 = new_matrix(20, 30);

    // matrix* m2 = new_matrix(rows, cols);
    // for (uint8 r = 0; r < rows; ++r) {
    //     for (uint8 c = 0; c < cols; ++c) {
    //         if (r == c) {
    //             matrix_write(m2, r, c, 100);
    //         }
    //         else {
    //             matrix_write(m2, r, c, 0);
    //         }
    //     }
    // }

    // free(m4);

    // for (int i = 0; i < 10000; ++i) {
    //     matrix* m3 = matmul(m1, m2);
    //     free_matrix(m3);
    // }

    // free_matrix(m1);
    // free_matrix(m2);

    // _write_debug_value((uint32)dd);

    // _write_debug_value(sizeof(struct block_t));

    char* x = fast_malloc(10);
    *x = 0xFF;
    x = uncache(x);
    *x = 0xEE;

    // malloc(8);
    while (1);
}