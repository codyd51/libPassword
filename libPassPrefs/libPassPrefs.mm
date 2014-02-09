#import <Preferences/Preferences.h>

@interface libPassPrefsListController: PSListController {
}
@end

@implementation libPassPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"libPassPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
