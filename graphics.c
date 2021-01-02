#include "graphics.h"
#include "core.h"

void draw_pixel(int x, int y, int color){
    SCREENBUFFER[y*SCREEN_W + x] = color;
}

void graphics_init(){
    REG_DISPLAYCONTROL = VIDEOMODE_3 | BGMODE_2;
}