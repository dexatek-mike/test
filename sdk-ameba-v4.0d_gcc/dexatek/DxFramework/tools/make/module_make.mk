#
# --- Dexatek Framework Configuration ---
#
#   module_make.mk: main makefile
#

# 1. Set default module configuration

PATH_THIS_MODULE := $(abspath $(dir $(MODULE_MAKEFILE)))
export PATH_THIS_MODULE

include $(PATH_DX_MAKE)/common.mk

SUBMODULES ?=

# 2. execute local module.mk

include $(MODULE_MAKEFILE)

clean:
	$(summary) RM module_local.mk
	rm -f module_local.mk

module_local.mk::
	@echo 'do nothing for now' > $@
