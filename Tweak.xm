#import <libcolorpicker.h>
#import <Header.h>

#define prefs @"/var/mobile/Library/Preferences/com.yourcompany.squarecode.plist"

CGFloat cornerRadius;
CGFloat PadRadius;
UIColor *color = [UIColor whiteColor];
UIColor *padcolor = [UIColor clearColor];
// UIColor *dotcolor = [UIColor clearColor];
BOOL lockscreenText = NO;
NSString *text;
BOOL padEnable = NO;
BOOL padbuttonEnable = NO;
BOOL padbuttonColorEnable = NO;
static NSMutableDictionary *pref;


void reloadPrefs(){
	pref = nil;
	pref = [[NSMutableDictionary alloc] initWithContentsOfFile:[prefs stringByExpandingTildeInPath]];
	
	color = LCPParseColorString([pref objectForKey:@"PasscodeColor"], @"#ffffff");
	padcolor = LCPParseColorString([pref objectForKey:@"PadColor"], @"#707070");
	// dotcolor = LCPParseColorString([pref objectForKey:@"DotColor"], @"000000");

	if ([pref objectForKey:@"cornerRadius"])cornerRadius = [[pref objectForKey:@"cornerRadius"] floatValue];
	if ([pref objectForKey:@"PadRadius"])PadRadius = [[pref objectForKey:@"PadRadius"] floatValue];
	if ([pref objectForKey:@"lockscreenText"])lockscreenText = [[pref objectForKey:@"lockscreenText"] boolValue];
	if ([pref objectForKey:@"lstext"])text = [pref objectForKey:@"lstext"];
	if ([pref objectForKey:@"PadEnable"])padEnable = [[pref objectForKey:@"PadEnable"] boolValue];
	if ([pref objectForKey:@"PadButtonEnable"]) padbuttonEnable = [[pref objectForKey:@"PadButtonEnable"] boolValue];
	if ([pref objectForKey:@"PadButtonColorEnable"]) padbuttonColorEnable = [[pref objectForKey:@"PadButtonColorEnable"] boolValue];
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  reloadPrefs();
}

%hook TPNumberPadButton

- (UIView *)circleView{
	reloadPrefs();
	UIView *view = %orig;
	if (padbuttonEnable){
		view.layer.cornerRadius = cornerRadius;
	}
	if (padbuttonColorEnable){
			view.backgroundColor = color;
	}
	return view;
}

%end

%hook TPNumberPad

- (void)_layoutGrid{
	reloadPrefs();
	if (padEnable){
		self.backgroundColor = padcolor;
		self.layer.cornerRadius = PadRadius;
	}
	%orig;
}

%end
//passcode dot
%hook SBSimplePasscodeEntryFieldButton

- (void) layoutSubviews {
	%orig;
	// reloadPrefs();
	// UIView *view = MSHookIvar<UIView *>(self, "_ringView");
	// view.backgroundColor = dotcolor;
}

%end
//Passcode Text
%hook SBUIPasscodeLockViewWithKeypad

- (void)layoutSubviews{
	%orig;
	reloadPrefs();
	UILabel *title = MSHookIvar<UILabel *>(self, "_statusTitleView");	
	if (lockscreenText){
		title.text = text;
	}
}
%end

%ctor {
	@autoreleasepool {
    pref = [[NSMutableDictionary alloc] initWithContentsOfFile:[prefs stringByExpandingTildeInPath]];
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.yourcompany.squarecode/update"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    reloadPrefs();
  }
}