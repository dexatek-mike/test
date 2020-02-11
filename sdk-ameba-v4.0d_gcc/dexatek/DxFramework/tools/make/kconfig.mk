#
# --- Dexatek Framework Configuration ---
#
#   kconfig.mk: makefile to configure framework
#

KCONFIG_TOOL_DIR=$(PATH_DX_KCONFIG)
MODULE_KCONFIGS := $(foreach module,$(PATH_MODULES),$(wildcard $(module)/Kconfig))

ifdef MSYSTEM
# change from Unix-style paths to Windows-style paths for kconfiglib
MODULE_KCONFIGS := $(shell cygpath -w $(MODULE_KCONFIGS) > /dev/null 2>&1)
endif

SDKCONFIG ?= $(PATH_OUT_CONFIG)/sdkconfig
SDKCONFIG_DEFAULTS ?= $(PATH_OUT_CONFIG)/sdkconfig.defaults

# mconf-idf and conf-idf cannot be made simultaneously in parallel make
$(KCONFIG_TOOL_DIR)/mconf-idf: $(KCONFIG_TOOL_DIR)/conf-idf

# reset MAKEFLAGS as the menuconfig makefile uses implicit compile rules
$(KCONFIG_TOOL_DIR)/mconf-idf $(KCONFIG_TOOL_DIR)/conf-idf: $(wildcard $(KCONFIG_TOOL_DIR)/*.c)
	MAKEFLAGS="" CC=$(HOSTCC) LD=$(HOSTLD) \
	$(MAKE) -C $(KCONFIG_TOOL_DIR)

# cannot find the configuration file; create it
ifeq ("$(wildcard $(SDKCONFIG))","")
ifeq ("$(filter $(TARGETS_NO_INTERACTION), $(MAKECMDGOALS))","")
# get the initial config for a non-interactive item
$(SDKCONFIG): menuconfig
menuconfig: defconfig
else
$(SDKCONFIG): defconfig
endif
endif

# macro for the commands to run kconfig tools conf-idf or mconf-idf.
# $1 is the name (& args) of the conf tool to run
define RunConf
	mkdir -p $(PATH_OUT_CONFIG)
	mkdir -p $(PATH_OUT)/include/config
	cd $(PATH_OUT); KCONFIG_AUTOHEADER=$(abspath $(PATH_OUT)/include/sdkconfig.h) \
	MODULE_KCONFIGS="$(MODULE_KCONFIGS)" KCONFIG_CONFIG=$(SDKCONFIG) srctree=$(PATH_MENU_ROOT) \
	$(KCONFIG_TOOL_DIR)/$1 $(PATH_MENU_ROOT)/Kconfig
endef


# run configuration generation on the first make pass
ifndef MAKE_RESTARTS
menuconfig: $(KCONFIG_TOOL_DIR)/mconf-idf
	$(summary) MENUCONFIG
ifdef BATCH_BUILD
	@echo "Can't run interactive configuration inside non-interactive build process."
	@echo ""
	@echo "Open a command line terminal and run 'make menuconfig' from there."
	@echo "See esp-idf documentation for more details."
	@exit 1
else
	$(call RunConf,mconf-idf)
endif

# create the default config based on the file SDKCONFIG_DEFAULTS
defconfig: $(KCONFIG_TOOL_DIR)/conf-idf
	$(summary) DEFCONFIG
ifneq ("$(wildcard $(SDKCONFIG_DEFAULTS))","")
	cat $(SDKCONFIG_DEFAULTS) >> $(SDKCONFIG)  # append defaults to sdkconfig, will override existing values
endif
	$(call RunConf,conf-idf --olddefconfig)

$(SDKCONFIG_MAKEFILE) $(PATH_OUT)/include/sdkconfig.h: $(KCONFIG_TOOL_DIR)/conf-idf $(SDKCONFIG) $(MODULE_KCONFIGS) | $(call prereq_if_explicit,defconfig) $(call prereq_if_explicit,menuconfig)
	$(summary) GENCONFIG
ifdef BATCH_BUILD  # can't prompt for new config values like on terminal
	$(call RunConf,conf-idf --olddefconfig)
endif
	$(call RunConf,conf-idf --silentoldconfig)
	touch $(SDKCONFIG_MAKEFILE) $(PATH_OUT)/include/sdkconfig.h  # ensure newer than sdkconfig

else # MAKE_RESTARTS
# skip config generation on subsequent make passes
defconfig:
menuconfig:
endif


.PHONY: clean-kconfig defconfig menuconfig
kconfig-clean:
	$(summary) RM CONFIG
	MAKEFLAGS="" $(MAKE) -C $(KCONFIG_TOOL_DIR) clean
	rm -rf $(PATH_OUT)/include/config $(PATH_OUT)/include/sdkconfig.h
