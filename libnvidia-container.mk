#########################################################
#
# libnvidia-container
#
#########################################################

LIBNVIDIA_CONTAINER_VERSION = 1.15.0
LIBNVIDIA_CONTAINER_SITE = https://github.com/NVIDIA/libnvidia-container/archive/v$(LIBNVIDIA_CONTAINER_VERSION).tar.gz
LIBNVIDIA_CONTAINER_LICENSE = Apache-2.0
LIBNVIDIA_CONTAINER_LICENSE_FILES = LICENSE
LIBNVIDIA_CONTAINER_DEPENDENCIES = libseccomp

define LIBNVIDIA_CONTAINER_BUILD_CMDS
    $(MAKE) -C $(@D) \
        CC="$(TARGET_CC)" \
        CXX="$(TARGET_CXX)" \
        RANLIB="$(TARGET_RANLIB)" \
        AR="$(TARGET_AR)" \
        PREFIX="$(STAGING_DIR)" \
        install
endef

define LIBNVIDIA_CONTAINER_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 644 $(@D)/include/*.h $(TARGET_DIR)/usr/include/
    $(INSTALL) -D -m 755 $(@D)/libnvidia-container.so.$(LIBNVIDIA_CONTAINER_VERSION) $(TARGET_DIR)/usr/lib/
    ln -sf libnvidia-container.so.$(LIBNVIDIA_CONTAINER_VERSION) $(TARGET_DIR)/usr/lib/libnvidia-container.so
endef

$(eval $(generic-package))
