#!/usr/bin/bash

# 设置分辨率
# $cvt 1600 900
# $xrandr
xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode VGA-1 "1600x900_60.00"
xrandr --output VGA-1 --mode "1600x900_60.00"


