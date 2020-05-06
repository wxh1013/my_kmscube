INCDIR := $(shell pwd)

SRCS = $(wildcard src/*.cpp)
SRCS += $(wildcard src/*.c)

CC_INC += -I$(INCDIR)/third_lib/libdrm/include \
        -I$(INCDIR)/third_lib/libdrm/include/libdrm \
	-I$(INCDIR)/third_lib/libopenGL_ES_EGL/include\
        -I$(INCDIR)/third_lib/libgbm/include

CC_LIB +=-L$(INCDIR)/third_lib/libdrm/lib\
         -L$(INCDIR)/third_lib/libopenGL_ES_EGL/lib\
         -L$(INCDIR)/third_lib/libgbm/lib
          	
C_OBJS  = $(patsubst %.c, %.o, $(SRCS))



TARGET=my_kmscube

CC      = gcc -std=gnu99
CXX     = g++
LINK    = gcc  
CFLAGS  = -g     $(CC_INC)

all:$(TARGET)
$(TARGET): $(C_OBJS)
	$(LINK) -o $@ $^ $(CC_LIB) -ldrm -lgbm -lEGL -lGLESv2 -lm -lrt
%.o:%.c
	$(CC)   $(CFLAGS)  -c -o $@ $<
.PHONY:clean
clean:
	rm -rf *.o $(TARGET) $(CXX_OBJS) $(C_OBJS)
