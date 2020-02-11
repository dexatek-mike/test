#
# --- Dexatek Framework Configuration ---
#
#   common.mk: common utilities
#

SDKCONFIG_MAKEFILE ?= $(abspath $(PATH_OUT)/include/config/auto.conf)
-include $(SDKCONFIG_MAKEFILE)
# for sub-makes
export SDKCONFIG_MAKEFILE

# BATCH_BUILD disables interactive terminal features
ifdef BATCH_BUILD
V ?= 1
endif

VERBOSE ?=
V ?= $(VERBOSE)
ifeq ("$(V)","1")
summary := @true
details := @echo
else
summary := @echo
details := @true

# disable echoing of commands, directory names
MAKEFLAGS += --silent
endif  # $(V)==1

ifdef CONFIG_MAKE_WARN_UNDEFINED_VARIABLES
MAKEFLAGS += --warn-undefined-variables
endif

# make utilities

SEPARATOR:="*******************************************************************************"

# example $(call dequote,$(CONFIG_XXX))
define dequote
$(subst ",,$(1))
endef

# $(1) path to resolve
# $(2) directory to resolve non-absolute path against
#
# example $(call resolvepath,$(CONFIG_PATH),$(CONFIG_DIR))
define resolvepath
$(abspath $(foreach dir,$(1),$(if $(filter /%,$(dir)),$(dir),$(subst //,/,$(2)/$(dir)))))
endef

# example $(call prereq_if_explicit,erase_flash)
define prereq_if_explicit
$(filter $(1),$(MAKECMDGOALS))
endef

# to kill duplicate items in a list
define uniq
$(if $1,$(firstword $1) $(call uniq,$(filter-out $(firstword $1),$1)))
endef

# to strip leading ../s from a path
define strip_parent_dirs
$(foreach path,$(1),$(if $(subst ..,,$(path)),$(if $(filter ../%,$(path)),$(call stripLeadingParentDirs,$(patsubst ../%,%,$(path))),$(path)),.))
endef
