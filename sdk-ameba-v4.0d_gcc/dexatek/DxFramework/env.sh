#!/bin/bash
# set -x

export PATH_ROOT=$( readlink -f $( dirname -- $0 ) )
export PATH_KCONFIG=$PATH_ROOT/tools/kconfig
export PATH_MENU_ROOT=$PATH_ROOT
export PATH_DX_MAKE=$PATH_MENU_ROOT/tools/make
export PATH_DX_KCONFIG=$PATH_MENU_ROOT/tools/kconfig
export PATH_OUT=$PATH_MENU_ROOT/out
export PATH_OUT_CONFIG=$PATH_OUT/config
export SDKCONFIG_DEFAULTS=$PATH_OUT_CONFIG/sdkconfig.defaults
# mono, blackbg
export MENUCONFIG_COLOR=classic

alias make="make -C $PATH_DX_MAKE"
