#include "../include/graphics.h"
#include "../include/core.h"
#include "../include/mem.h"

int main(){
    graphics_init();
    mem_init();
    // draw_pixel(0,0,0x0FF0);
    char * ptr = (char *)(malloc(0x3f000 - 4));
    *ptr = 'A';



    // char * ptr2 = (char *)malloc(26);
    // char * x = "abcdefghijklmnopqrstuvwxyz";
    // for(int i = 0; i < 26; i++){
    //     ptr2[i] = x[i];
    // }

    // char * ptr31 = (char *)malloc(4);
    // char * x1 = "deck";
    // for(int i = 0; i < 4; i++){
    //     ptr31[i] = x1[i];
    // }

    char * ptr2 = malloc(1);

    if(ptr2 == NULL){
        draw_pixel(100, 100, 0xFFFF);
    } else {
        draw_pixel(100, 100, 0x00FF);
    }
   
    while(1);
}