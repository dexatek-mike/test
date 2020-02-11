#
# --- Dexatek Framework Configuration ---
#
#   Makefile: main makefile
#

.PHONY: menuconfig defconfig clean list-modules

DEBUG_MAKE := 0
MAKECMDGOALS ?= menuconfig

help:
	@echo "--- Dexatek Framework Make system ---"
	@echo ""
	@echo "Supported Commands:"
	@echo "  make menuconfig - Configure Framework"
	@echo "  make defconfig - Use default configuration options"
	@echo "  make clean - Remove all object files"
	@echo "  make list-modules - List all modules"
	@echo ""

TARGETS_NO_INTERACTION += defconfig clean% %clean help list-modules

ifndef MAKE_RESTARTS
# check dependencies
ifeq ("$(filter 4.% 3.81 3.82,$(MAKE_VERSION))","")
$(warning GNU Make versions $(MAKE_VERSION); SHOULD be 3.81 or newer.)
endif
endif

# check supported shells
ifdef MSYSTEM
ifneq ("$(MSYSTEM)","MINGW32")
$(warning supports system MINGW32 but $(MSYSTEM) is detected.)
endif
endif

# validate target syntax
ifneq ("$(filter clean% %clean,$(MAKECMDGOALS))" ,"")
ifneq ("$(filter-out clean% %clean,$(MAKECMDGOALS))", "")
$(error 'make clean' should not be called with additional parameters)
endif
endif

# check supported OS
OS ?=

# check root path; use a a real absolute path
# replace the Windows-style path 'C:/' with Unix-style '/c/'
ifeq ("$(OS)","Windows_NT")
# the make wildcard function returns an empty path string on MSYS2 and thus we
# don't use it.
PATH_DX_FRAMEWORK_SANITISED:=$(realpath $(PATH_MENU_ROOT))
else
PATH_DX_FRAMEWORK_SANITISED:=$(realpath $(wildcard $(PATH_MENU_ROOT)))
endif

ifeq ($(DEBUG_MAKE),1)
$(warning --- root folder of dexatek framework ---)
$(warning PATH_DX_FRAMEWORK_SANITISED = $(PATH_DX_FRAMEWORK_SANITISED))
$(warning PATH_MENU_ROOT = $(PATH_MENU_ROOT))
endif
export PATH_MENU_ROOT := $(PATH_DX_FRAMEWORK_SANITISED)

ifndef PATH_MENU_ROOT
$(error invalid environment variable PATH_MENU_ROOT=$(PATH_MENU_ROOT).)
endif


ifneq ("$(PATH_MENU_ROOT)","$(PATH_DX_FRAMEWORK_SANITISED)")
# Although not possible, this implies that the path was overriden and to fix it
# do the shell expansion
#   make PATH_MENU_ROOT=xxx
# other than
#   make PATH_MENU_ROOT="xxx"
# (xxx SHOULD be an absolute path)
$(error PATH_MENU_ROOT=$(PATH_MENU_ROOT) is overriden; PATH_DX_FRAMEWORK_SANITISED=$(PATH_DX_FRAMEWORK_SANITISED))
endif

ifneq ("$(PATH_MENU_ROOT)","$(subst :,,$(PATH_MENU_ROOT))")
$(error PATH_MENU_ROOT=$(PATH_MENU_ROOT) SHOULD not contain colons)
endif

# disable built-in make rules
MAKEFLAGS_BAK := $(MAKEFLAGS)
MAKEFLAGS += -rR
ifeq ($(DEBUG_MAKE),1)
$(warning --- dirty make rules ---)
$(warning MAKEFLAGS_BAK = $(MAKEFLAGS_BAK))
endif

ifeq ($(DEBUG_MAKE),1)
$(warning --- root folder of local make sytem ---)
$(warning PATH_DX_MAKE = $(PATH_DX_MAKE))
endif

# collections of makefiles that should be processed for each target
MAKEFILES_MUST_HAVE := $(abspath $(PATH_DX_MAKE)/Makefile $(PATH_DX_MAKE)/common.mk $(PATH_DX_MAKE)/module_make.mk $(firstword $(MAKEFILE_LIST)))
export MAKEFILES_MUST_HAVE
ifeq ($(DEBUG_MAKE),1)
$(warning --- collections of must-have makefiles ---)
$(warning MAKEFILES_MUST_HAVE = $(MAKEFILES_MUST_HAVE))
endif

# set the path to output files
ifndef PATH_OUT
PATH_OUT := $(PATH_MENU_ROOT)/out
endif
export PATH_OUT

# collect available modules
#   MODULES_ALL: specify all directories and the subsequent subdirectories as
#                active modules
#   MODULES: specify those containing module.mk as active modules
#
# use "make list-modules" to debug
PATH_MODULES_ALL := $(sort $(dir $(wildcard $(PATH_MENU_ROOT)/*/)))
MODULES_ALL := $(sort $(foreach comp,$(PATH_MODULES_ALL),$(lastword $(subst /, ,$(comp)))))
# use the directory name as the module name;
# e.g. my_module/module.mk gives a module named my_module
MODULES := $(dir $(foreach cd,$(PATH_MODULES_ALL),$(wildcard $(cd)/*/module.mk) $(wildcard $(cd)/module.mk)))
MODULES := $(sort $(foreach comp,$(MODULES),$(lastword $(subst /, ,$(comp)))))

ifeq ($(DEBUG_MAKE),1)
$(warning --- initial collections of modules ---)
$(warning PATH_MODULES_ALL = $(PATH_MODULES_ALL))
$(warning MODULES_ALL = $(MODULES_ALL))
$(warning MODULES = $(MODULES))
endif

MODULES_EXCLUDED ?=
#MODULES_EXCLUDED += $(notdir $(PATH_MENU_ROOT))
MODULES_EXCLUDED += \
    ProjectTemplate\
    out \
    tools \
    include \
    Utils

# exclude unwanted modules
MODULES_ALL := $(filter-out $(subst ",,$(MODULES_EXCLUDED)), $(MODULES_ALL)) 
export MODULES MODULES_ALL

ifeq ($(DEBUG_MAKE),1)
$(warning --- final collections of modules ---)
$(warning MODULES_EXCLUDED = $(MODULES_EXCLUDED))
$(warning MODULES_ALL = $(MODULES_ALL))
$(warning MODULES = $(MODULES))
endif

# resolve module paths after excluding unwanted modules
PATH_MODULES_ALL := $(foreach comp,$(MODULES_ALL),$(firstword $(foreach cd,$(PATH_MODULES_ALL),$(wildcard $(dir $(cd))$(comp) $(cd)/$(comp)))))
PATH_MODULES_HAVE_MK := $(foreach comp,$(MODULES),$(firstword $(foreach cd,$(PATH_MODULES_ALL),$(wildcard $(dir $(cd))$(comp) $(cd)/$(comp)))))
PATH_MODULES := $(PATH_MODULES_ALL)
export PATH_MODULES_ALL PATH_MODULES_HAVE_MK PATH_MODULES

ifeq ($(DEBUG_MAKE),1)
$(warning --- final module paths ---)
$(warning PATH_MODULES_ALL = $(PATH_MODULES_ALL))
$(warning PATH_MODULES_HAVE_MK = $(PATH_MODULES_HAVE_MK))
endif


# add submodules
SUBMODULES :=


# MODULE_LOCAL_VARS: list of auto-generated module_local.mk;
# available local variables:
#   SUBMODULES
MODULE_LOCAL_VARS := $(addsuffix /module_local.mk,$(notdir $(PATH_MODULES)))
MODULE_LOCAL_VARS := $(addprefix $(PATH_OUT)/,$(MODULE_LOCAL_VARS))
# use '-include' instead of 'include' to refrain from error on make 3.81
-include $(MODULE_LOCAL_VARS)

ifeq ($(DEBUG_MAKE),1)
$(warning --- module-specific local makefiles ---)
$(warning MODULE_LOCAL_VARS = $(MODULE_LOCAL_VARS))
endif

# variables common to modules
include $(PATH_DX_MAKE)/common.mk
# include the config generation targets after resolving module paths
include $(PATH_DX_MAKE)/kconfig.mk

$(PATH_OUT):
	mkdir -p $(PATH_OUT)


# default LDFLAGS
EXTRA_LDFLAGS ?=
LDFLAGS ?= -nostdlib \
	-Wl,--gc-sections	\
	-Wl,-static	\
	-Wl,--start-group	\
	-lgcc \
	-lstdc++ \
	-lgcov \
	-Wl,--end-group \
	-Wl,-EL \
	$(EXTRA_LDFLAGS)

# default CPPFLAGS, CFLAGS, CXXFLAGS
CPPFLAGS ?=
EXTRA_CPPFLAGS ?=
CPPFLAGS := $(CPPFLAGS) $(EXTRA_CPPFLAGS)

# Warnings-related flags relevant both for C and C++
CFLAGS_WARNING = \
	-Wall -Werror=all \
	-Wno-error=unused-function \
	-Wno-error=unused-but-set-variable \
	-Wno-error=unused-variable \
	-Wno-error=deprecated-declarations \
	-Wextra \
	-Wno-unused-parameter -Wno-sign-compare

CFLAGS_WARNING += -Wwrite-strings

# Flags which control code generation and dependency generation, both for C and C++
CXXFLAGS_COMMON = \
	-ffunction-sections -fdata-sections \
	-fstrict-volatile-bitfields \
	-mlongcalls \
	-nostdlib

# -fstack-protector
# -fstack-protector-strong
# -fstack-protector-all
CXXFLAGS_COMMON += -fstack-protector-all

# -Os
# -Og
OPTIMIZATION_FLAGS = -Os

# disable optimization assersions
CPPFLAGS += -DNDEBUG

DEBUG_FLAGS ?= -ggdb

CFLAGS ?=
EXTRA_CFLAGS ?=
CFLAGS := $(strip \
	-std=gnu99 \
	$(OPTIMIZATION_FLAGS) $(DEBUG_FLAGS) \
	$(CXXFLAGS_COMMON) \
	$(CFLAGS_WARNING) -Wno-old-style-declaration \
	$(CFLAGS) \
	$(EXTRA_CFLAGS))

CXXFLAGS ?=
EXTRA_CXXFLAGS ?=
CXXFLAGS := $(strip \
	-std=gnu++11 \
	-fno-rtti \
	$(OPTIMIZATION_FLAGS) $(DEBUG_FLAGS) \
	$(CXXFLAGS_COMMON) \
	$(CFLAGS_WARNING) \
	$(CXXFLAGS) \
	$(EXTRA_CXXFLAGS))

# -fexceptions
# -fno-exceptions
CXXFLAGS += -fno-exceptions

ARFLAGS := cru

export CFLAGS CPPFLAGS CXXFLAGS ARFLAGS

CC ?= gcc
LD ?= ld
AR ?= ar
OBJCOPY ?= objcopy
OBJDUMP ?= objdump
SIZE ?= size

HOSTCC := $(CC)
HOSTLD := $(LD)
HOSTAR := $(AR)
HOSTOBJCOPY := $(OBJCOPY)
HOSTSIZE := $(SIZE)
export HOSTCC HOSTLD HOSTAR HOSTOBJCOPY SIZE

# Set target compiler. Defaults to whatever the user has
# configured as prefix + ye olde gcc commands
CC := $(call dequote,$(CONFIG_TOOLPREFIX))gcc
CXX := $(call dequote,$(CONFIG_TOOLPREFIX))c++
LD := $(call dequote,$(CONFIG_TOOLPREFIX))ld
AR := $(call dequote,$(CONFIG_TOOLPREFIX))ar
OBJCOPY := $(call dequote,$(CONFIG_TOOLPREFIX))objcopy
OBJDUMP := $(call dequote,$(CONFIG_TOOLPREFIX))objdump
SIZE := $(call dequote,$(CONFIG_TOOLPREFIX))size
export CC CXX LD AR OBJCOPY OBJDUMP SIZE


# to recursively execute each module's sub-makefile
#   $(1): module path
#   $(2): module name
define make_module
+$(MAKE) -C $(PATH_OUT)/$(2) -f $(PATH_DX_MAKE)/module_make.mk MODULE_MAKEFILE=$(1)/module.mk MODULE_NAME=$(2)
endef

# to generate module-specific targets
#   $(1): module path
#   $(2): module name
define generate_module_target
.PHONY: module-$(2)-build module-$(2)-clean

module-$(2)-build: check-submodules $(call prereq_if_explicit, module-$(2)-clean) | $(PATH_OUT)/$(2)
	$(call make_module,$(1),$(2)) build

module-$(2)-clean: | $(PATH_OUT)/$(2) $(PATH_OUT)/$(2)/module_local.mk
	$(call make_module,$(1),$(2)) clean

$(PATH_OUT)/$(2):
	@mkdir -p $(PATH_OUT)/$(2)


# generate module_local.mk
$(PATH_OUT)/$(2)/module_local.mk: $(1)/module.mk $(MAKEFILES_MUST_HAVE) $(SDKCONFIG_MAKEFILE) | $(PATH_OUT)/$(2)
	$(call make_module,$(1),$(2)) module_local.mk
endef

$(foreach module,$(PATH_MODULES_ALL),$(eval $(call generate_module_target,$(module),$(notdir $(module)))))


clean: kconfig-clean

# phony target to validate submodules listed in SUBMODULES
check-submodules:

# method reserved to process submodule
#   $(1): submodule path relative to PATH_MENU_ROOT
define submodule_exec
check-submodules:
	@echo "exec submodule: $(1)"
endef

$(foreach submodule,$(subst $(PATH_MENU_ROOT)/,,$(filter $(PATH_MENU_ROOT)/%,$(SUBMODULES))),$(eval $(call submodule_exec,$(submodule))))


# list module information
list-modules:
	$(info $(call dequote,$(SEPARATOR)))
	$(details) "details test $(MODULE_NAME)"
	$(info $(call dequote,$(SEPARATOR)))
	$(info MODULES_EXCLUDED: $(MODULES_EXCLUDED))
	$(info $(call dequote,$(SEPARATOR)))
	$(info PATH_MODULES_ALL:)
	$(foreach cd,$(PATH_MODULES_ALL),$(info $(cd)))
	$(info $(call dequote,$(SEPARATOR)))
	$(info PATH_MODULES_HAVE_MK:)
	$(foreach cd,$(PATH_MODULES_HAVE_MK),$(info $(cd)))
	$(info $(call dequote,$(SEPARATOR)))
	$(info PATH_MODULES:)
	$(foreach cd,$(PATH_MODULES),$(info $(cd)))
	$(info $(call dequote,$(SEPARATOR)))
