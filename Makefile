include $(THEOS)/makefiles/common.mk

ARCHS=arm64
TWEAK_NAME = SquareCode
SquareCode_LIBRARIES = colorpicker
SquareCode_FILES = Tweak.xm
SquareCode_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall backboardd"
SUBPROJECTS += squarecode
include $(THEOS_MAKE_PATH)/aggregate.mk
