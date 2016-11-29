DEFINES = -DLINUX

CC = g++
CFLAGS = -m64 -std=c++11

LD = g++
LDFLAGS =

DIR_DEVLIBS = /usr/devlibs

INCLUDES = -I$(DIR_DEVLIBS)/include
