# 宏定义
DEFINES	= -DLINUX

# 编译
CC	= gcc
CPP	= g++
CFLAGS	= -m64 -std=c++11

# 链接
LD	= g++
LDFLAGS	=

# 创建静态库.a (from .o)
AR	= ar

# 开发库位置
DIR_DEVLIBS	= /usr/devlibs

# 头文件搜索路径
INCLUDES	= -I.

# 依赖库名模式
# 使用-l写依赖库时的替代规则 .LIBPATTERNS 变量定义
# 例如 $(EXE):-ldemo 将被替代为 $(EXE):-libdemo.so (或-libdemo.a)
.LIBPATTERNS	= lib%.so lib%.a		# 此为缺省值
