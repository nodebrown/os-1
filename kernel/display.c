void put_pixel(char val, int x, int y){
    char *vidseg = (char*) 0xa0000;
    vidseg[320*y+x] = val;
}


void rectangle(char val, int fill,int x1, int y1, int x2, int y2){
    for(int i=x1;i<x2;i++){
        for(int j=y1; j<y2; j++){
             put_pixel(val, i, j);
        }
    }
}

void clear(char val){
    rectangle(val,0,0,0,320,200);
}