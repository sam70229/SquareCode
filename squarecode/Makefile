include $(THEOS)/makefiles/common.mk

ARCHS=arm64
BUNDLE_NAME = squarecode
squarecode_LIBRARIES = colorpicker
squarecode_FILES = spRootListController.m stepperCell.m
squarecode_INSTALL_PATH = /Library/PreferenceBundles
squarecode_FRAMEWORKS = UIKit
squarecode_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/squarecode.plist$(ECHO_END)
