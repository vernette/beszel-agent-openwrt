include $(TOPDIR)/rules.mk

PKG_NAME:=beszel-agent
PKG_VERSION:=$(or $(BESZEL_VERSION),0.0.0)
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_linux_$(or $(BESZEL_GOARCH),arm64).tar.gz
PKG_SOURCE_URL:=https://github.com/henrygd/beszel/releases/download/v$(PKG_VERSION)/
PKG_HASH:=skip

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/beszel-agent
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Beszel monitoring agent
  URL:=https://github.com/henrygd/beszel
endef

define Package/beszel-agent/description
  Lightweight server monitoring agent for Beszel hub
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	tar -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Build/Compile
	if command -v upx >/dev/null 2>&1; then \
		upx --best --lzma $(PKG_BUILD_DIR)/beszel-agent || true; \
	fi
endef

define Package/beszel-agent/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/beszel-agent $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/beszel-agent.init $(1)/etc/init.d/beszel-agent

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/beszel-agent.config $(1)/etc/config/beszel-agent
endef

define Package/beszel-agent/conffiles
/etc/config/beszel-agent
endef

$(eval $(call BuildPackage,beszel-agent))
