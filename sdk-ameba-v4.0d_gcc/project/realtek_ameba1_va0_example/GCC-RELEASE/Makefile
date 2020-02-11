DEBUG_MAKE ?= n
NATIVE_BUILD ?= n
RELEASE_BUILD ?= n
BUILD_MP_TOOL ?= n
DEXATEK_PROJECT_DIR := $(abspath $(shell find .. -iname "EWARM*"))
DEXATEK_MAKEFILE := $(DEXATEK_PROJECT_DIR)/dk_project.mk
ifeq ($(DEBUG_MAKE),y)
$(warning --- collection of Dexatek makefiles ---)
$(warning DEXATEK_PROJECT_DIR = $(DEXATEK_PROJECT_DIR))
$(warning DEXATEK_MAKEFILE = $(DEXATEK_MAKEFILE))
endif

export DEBUG_MAKE NATIVE_BUILD DEXATEK_PROJECT_DIR

-include $(DEXATEK_MAKEFILE)

all: ram_all

OS := $(shell uname)

.PHONY: toolchain
toolchain:
ifeq ($(OS),Linux)
ifndef DOCKER_IMAGE
	if [ ! -d ../../../tools/arm-none-eabi-gcc/4_8-2014q3 ] ; then tar -jxf ../../../tools/arm-none-eabi-gcc/gcc-arm-none-eabi-4_8-2014q3-20140805-linux.tar.bz2 -C ../../../tools/arm-none-eabi-gcc/ ; mv ../../../tools/arm-none-eabi-gcc/gcc-arm-none-eabi-4_8-2014q3 ../../../tools/arm-none-eabi-gcc/4_8-2014q3 ; fi
endif
else
	if [ ! -d ../../../tools/arm-none-eabi-gcc/4_8-2014q3 ] ; then tar -xf ../../../tools/arm-none-eabi-gcc/4_8-2014q3.tar -C ../../../tools/arm-none-eabi-gcc/ ; fi
endif
	
	
.PHONY: ram_all
ram_all: toolchain
	@$(MAKE) -f application.mk

.PHONY: mp
mp: toolchain
	@$(MAKE) -f application.mk mp

.PHONY: clean
clean:
	@$(MAKE) -f application.mk clean
	
.PHONY: flash debug ramdebug setup
setup:
	@$(MAKE) -f application.mk $(MAKECMDGOALS)

flash: toolchain
	@$(MAKE) -f application.mk flashburn
	
debug: toolchain
	@$(MAKE) -f application.mk debug	

ramdebug: toolchain
	@$(MAKE) -f application.mk ramdebug	