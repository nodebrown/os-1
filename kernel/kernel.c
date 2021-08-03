#include "display.h"
#include "lowlevel.h"

void kernel_main(){
    clear(1);
    rectangle(0x5,0,100,100, 200, 200 );
    rectangle(0x3,0,100,0, 200, 100 );
    rectangle(0x2,0,0,0, 100, 100 );
    rectangle(0x4,0,200,100, 320, 200 );
}


