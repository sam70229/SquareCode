#include "spRootListController.h"
#include <spawn.h>
#include <signal.h>
#include "libcolorpicker.h"

#define prefs @"/var/mobile/Library/Preferences/com.yourcompany.squarecode.plist"

@implementation spRootListController

-(id)readPreferenceValue:(PSSpecifier *)specifier {
    NSDictionary *POSettings = [NSDictionary dictionaryWithContentsOfFile:prefs];

    if(!POSettings[specifier.properties[@"key"]]) {
        return specifier.properties[@"default"];
    }
    return POSettings[specifier.properties[@"key"]];
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*) specifier {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefs]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    [defaults writeToFile:prefs atomically:YES];
    CFStringRef CPPost = (CFStringRef)CFBridgingRetain(specifier.properties[@"PostNotification"]);
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CPPost, NULL, NULL, YES);
}

- (void)viewWillAppear: (BOOL)animated {
	[self reload];
	[super viewWillAppear:animated];
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)respring {
	pid_t pid;
	int status;
	const char *argv[] = {"killall", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
	waitpid(pid, &status, WEXITED);
}

- (void)finish {
	[self.view endEditing:YES];
}

@end
