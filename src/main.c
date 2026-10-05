#include "window.h"
#include <stdio.h>

DEFINE_WINDOW(MainWindow, 100, 120);

int main(void) {
    MainWindow win = INIT_WINDOW(MainWindow);
    printf("%d %d %d\n", GET_HEIGHT(MainWindow), GET_WIDTH(MainWindow),
           GET_SIZE(MainWindow));
    return 0;
}
