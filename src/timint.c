#include "../include/timint.h"
#include "../include/mem.h"
#include "../include/graphics.h"

typedef void (*fnptr)(void);

#define INT_MASTER_ENABLE (uint16 *) 0x04000208
#define INT_ENABLE (uint16 *) 0x04000200
#define IRQ_ACK (uint16 *) 0x04000202
#define IRQ_HANDLER (fnptr *) 0x03007FFC
#define DISPSTAT (uint16 *) 0x04000004
#define VBLANK_IE 0b1
#define VBLANK_DISPSTAT 0b1000

const uint32 color_to_fill[] = { RED, WHITE, BLUE, GREEN };

void interrupt_function() {
    uint32 debug_value = _read_debug_value();
    _write_debug_value(debug_value + 1);
    fill_color(color_to_fill[debug_value % 4]);
    *IRQ_ACK = VBLANK_IE;
}

void interrupt_init() {
    *INT_MASTER_ENABLE = 1;
    *INT_ENABLE |= VBLANK_IE;
    *DISPSTAT |= VBLANK_DISPSTAT;
    *IRQ_HANDLER = &interrupt_function;
}
