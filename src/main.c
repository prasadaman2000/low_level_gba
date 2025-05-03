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

    uint8 rows = 3;
    uint8 cols = 3;

    matrix* m1 = new_matrix(rows, cols);
    for (uint8 r = 0; r < rows; ++r) {
        for (uint8 c = 0; c < cols; ++c) {
            matrix_write(m1, r, c, r);
        }
    }

    matrix* m2 = new_matrix(rows, cols);
    for (uint8 r = 0; r < rows; ++r) {
        for (uint8 c = 0; c < cols; ++c) {
            matrix_write(m2, r, c, c);
        }
    }


    for (int i = 0; i < 100000; ++i) {
        matrix* m3 = matmul(m1, m2);
        matrix_copy(m3, m2);
        free_matrix(m3);
    }

    // _write_debug_value((uint32)dd);

    fill_color(WHITE);

    while (1);
}