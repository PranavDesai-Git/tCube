#pragma once

#define DEFINE_WINDOW(WindowName, W, H)                                        \
    enum { WindowName##_W = (W), WindowName##_H = (H) };                       \
    typedef struct {                                                           \
        int width;                                                             \
        int height;                                                            \
        char display[(W) * (H)];                                               \
    } WindowName

#define INIT_WINDOW(WindowName)                                                \
    {.width = WindowName##_W, .height = WindowName##_H}

#define GET_HEIGHT(WindowName) (WindowName##_H)
#define GET_WIDTH(WindowName) (WindowName##_W)
#define GET_SIZE(WindowName) (WindowName##_W) * (WindowName##_H)
