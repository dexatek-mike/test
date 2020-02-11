#!/bin/bash
#set -x

TOOLS_BASE_PATH=$(realpath ../../tools)
export GCC_CROSS_COMP=$TOOLS_BASE_PATH/arm-none-eabi-gcc/4_8-2014q3/bin
export IAR_UTILITY=$TOOLS_BASE_PATH/iar_utility/common/tools/
export GCC_UTILITY=$TOOLS_BASE_PATH/gcc_utility/

PROJECT_TOOLS_LINK=$(realpath .)/tools

unlink $PROJECT_TOOLS_LINK
ln -s $TOOLS_BASE_PATH $PROJECT_TOOLS_LINK
