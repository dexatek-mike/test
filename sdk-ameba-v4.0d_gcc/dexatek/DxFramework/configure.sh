#!/bin/bash
# set -x

# param1: full path to be converted
function full_path_from_windows_to_posix
{
    echo "/$1" | sed -e 's/\\/\//g' -e 's/://'
}

# param1: relative path
function get_absolute_path
{
    echo $(readlink -f ./$1)
}

# param1: process status
# param2: error message
function exception
{
    if [ $1 -ne 0 ] ; then
        echo -e "\033[1;31mError\033[1;32m($THIS_FILE)\033[0m: $2"
        exit 1
    fi
}

# param1: message string
function script_info
{
    echo -e "\033[1;33mInfo\033[1;32m($THIS_FILE)\033[0m: $1"
}

# param1: message string
function script_warn
{
    echo -e "\033[1;31mWARNING\033[1;32m($THIS_FILE)\033[0m: $1"
}

# param1: file path
function check_if_exists
{
    if [ ! -f "$1" ] && [ ! -d "$1" ] ; then
        exception 1 "$1 does not exist"
    fi
}


THIS_FILE=$( basename "$0" )
THIS_DIR=$( readlink -f $( dirname "$0" ) )
BUILD_TIME=$( date +'20%y%m%d-%H-%M-%S' )
if [ $PATH_ROOT"x" == "x" ] ; then
    PATH_ROOT=$THIS_DIR
else
    script_info "received root path from batch file"
    script_info "PATH_ROOT=$PATH_ROOT"
    PATH_ROOT=$( full_path_from_windows_to_posix $PATH_ROOT )
    #remove the last character '/'
    PATH_ROOT=${PATH_ROOT%/};
    script_info "rename to posix-style"
    script_info "PATH_ROOT=$PATH_ROOT"
fi

PATH_KCONFIG=$PATH_ROOT/tools/kconfig

export PATH_MENU_ROOT=$PATH_ROOT
export PATH_DX_MAKE=$PATH_MENU_ROOT/tools/make
export PATH_DX_KCONFIG=$PATH_MENU_ROOT/tools/kconfig
export PATH_OUT=$PATH_MENU_ROOT/out
export PATH_OUT_CONFIG=$PATH_OUT/config

export SDKCONFIG_DEFAULTS=$PATH_OUT_CONFIG/sdkconfig.defaults

# mono, blackbg
export MENUCONFIG_COLOR=classic

PATH_DX_SUBSHELL=$PATH_MENU_ROOT/tools/msys32
DX_SUBSHELL=$PATH_DX_SUBSHELL/mingw32.exe
DX_SUBSHELL_MAKE=$PATH_DX_SUBSHELL/usr/bin/make.exe
SDKCONFIG_H=$PATH_OUT/include/sdkconfig.h
SDKCONFIG_RAW=$PATH_OUT_CONFIG/sdkconfig

# workaround; add paths containing necessary tools
PATH=$PATH:$PATH_KCONFIG:$PATH_DX_SUBSHELL/usr/bin


# param1: output path
function copy_target_objects
{
    if [ $1"x" != "x" ] ; then
        cp $SDKCONFIG_H $1
        cp $SDKCONFIG_RAW $1
    else
        script_warn "invalid output path: $1"
    fi
}


#-------------------------------------------------------------------------------
#   Main Process
#-------------------------------------------------------------------------------
file_out=$PATH_MENU_ROOT
cmd='null'
file_defconfig=
is_windows=0
is_defconfig=0
is_silent=0

temp=`getopt \
      -o o:,c:,i: \
      --long out:,command:,silent \
      -- "$@" 2>/dev/null`
# rearrange the input argements;
# put those not conforming to getopt rules to the end of the line;
# postfix --
eval set -- "$temp"
while :
do [ -z "$1" ] && break;
    case "$1" in
        -o|--out) file_out=$( get_absolute_path $2 ) ; mkdir -p $file_out ; shift 2 ;;
        -c|--command) cmd=$2 ; shift 2 ;;
        -i) file_defconfig=$( get_absolute_path $2 ) ; is_defconfig=1 ; shift 2 ;;
        --silent) is_silent=1 ; shift 1 ;;
        --) shift;;
        *) exception $? "Unknown Argument $1";;
    esac
done

# validate input parameters
script_info "output path: $file_out"

if [ "$MSYSTEM" == "MINGW32" ] ; then
    is_windows=1 ;
    script_info "running on Windows" ;
fi

if [ $is_defconfig -eq 1 ] ; then
    check_if_exists $file_defconfig ;
else
    file_defconfig=$file_out/sdkconfig ;
fi

mkdir -p $PATH_OUT_CONFIG
cp $file_defconfig $SDKCONFIG_DEFAULTS ;

if [ $is_silent -eq 1 ] ; then
    check_if_exists $file_defconfig ;
    cp $file_defconfig $SDKCONFIG_DEFAULTS ;
    cmd='defconfig' ;
fi

script_info "defconfig: $file_defconfig"
script_info "make target: $cmd"

case $cmd in
    'menuconfig' | 'null')
        pushd $PATH_DX_MAKE ;

        # load defult config
        # use sdkconfig in the output directory if not specified
        if [ -f "$file_defconfig" ] ; then
            cp $file_defconfig $SDKCONFIG_DEFAULTS ;
            make defconfig ;
        fi

        # interactive menuconfig interface
        make menuconfig ;

        # reload new config to ensure the sdkconfig.h is updated
        cp $SDKCONFIG_RAW $SDKCONFIG_DEFAULTS ;
        make defconfig ;

        # copy necessary files to the output folder
        copy_target_objects $file_out ;

        popd ;;
    'defconfig')
        export BATCH_BUILD=1 ;
        pushd $PATH_DX_MAKE ;

        cp $file_defconfig $SDKCONFIG_DEFAULTS ;
        make defconfig ;
        copy_target_objects $file_out

        popd ;;
    'clean')
        pushd $PATH_DX_MAKE ;
        make $cmd
        popd ;
        rm $PATH_OUT_CONFIG/* ;
        rm $PATH_OUT/include/* -r ;
        ;;
    'kconfig-clean' | 'help' | 'list-modules')
        pushd $PATH_DX_MAKE ;
        make $cmd
        popd ;;
    *)
        exception -2 "bad command: $cmd" ;;
esac

exit 0
