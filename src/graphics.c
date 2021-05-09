#include "../include/graphics.h"
#include "../include/core.h"

void draw_pixel(int x, int y, uint16 color){
    SCREENBUFFER[y*SCREEN_W + x] = color;
}

void graphics_init(){
    REG_DISPLAYCONTROL = VIDEOMODE_3 | BGMODE_2;
}

void fill_color(uint16 color){
    for(int i = 0; i < SCREEN_H; i++){
        for(int j = 0; j < SCREEN_W; j++){
            draw_pixel(j, i, color);
        }
    }
}