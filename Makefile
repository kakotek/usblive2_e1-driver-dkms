# Top-level out-of-tree Makefile for em28xx video/audio modules

KDIR ?= /lib/modules/$(shell uname -r)/build
PWD  := $(shell pwd)

# Build these modules (add/remove lines per your needs)
obj-m += em28xx.o
obj-m += em28xx-v4l.o
obj-m += em28xx-alsa.o

# How those modules are composed (mirror the in-tree em28xx Makefile, but with paths)
em28xx-objs       := em28xx/em28xx-core.o em28xx/em28xx-i2c.o em28xx/em28xx-cards.o em28xx/em28xx-camera.o
em28xx-v4l-objs   := em28xx/em28xx-video.o em28xx/em28xx-vbi.o
em28xx-alsa-objs  := em28xx/em28xx-audio.o

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
