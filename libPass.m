
#import "libPass.h"


NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.bd452.libPass.plist"];
NSString *passCode = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"savedPasscode"]];

%hook SBLockScreenManager

- (void)unlockUIFromSource:(int)fp8 withOptions:(id)fp12 {
	isUsingAction = NO;
	%orig;
}

- (BOOL)attemptUnlockWithPasscode:(id)fp8 {
	
	
	
	if (isUsingAction) {
		//NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.bd452.libPass.plist"];
		
		//tweakEnabled = [[prefs objectForKey:@"tweakIsEnabled"] boolValue];
		//NSString *savedCode = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"savedPasscode"]];
		
		fp8 = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"savedPasscode"]];
		//[prefs release];
		//[savedCode release];
	}
	
	
	
	
	
	return %orig;
	
}

- (void)_finishUIUnlockFromSource:(int)fp8 withOptions:(id)fp12 {
	
	
	[libPass setIsPasscodeForced:NO];
	
	
	%orig;
}

%end



%hook SBDeviceLockController

- (BOOL)attemptDeviceUnlockWithPassword:(id)fp8 appRequested:(BOOL)fp12 {
	
	
	//NSLog(@"%@",passCode);
	
	
	if (isUsingAction) {
		//NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.bd452.libPass.plist"];
		//tweakEnabled = [[prefs objectForKey:@"tweakIsEnabled"] boolValue];
		//NSString *savedCode = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"savedPasscode"]];
		
		fp8 = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"savedPasscode"]];
		//[prefs release];
		//[savedCode release];
	}
	
	
	return %orig;
	
}


%end


@implementation libPass
//@synthesize isPasscodeForced;

+(void)unlockWithCodeEnabled:(BOOL)enabled {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//NSDictionary *prefs=[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.bd452.libPass.plist"];
	//tweakEnabled = [[prefs objectForKey:@"tweakIsEnabled"] boolValue];
	//passCode = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"savedPasscode"]];
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/com.bd452.libPass.plist"];
	//[prefs release];
	if (fileExists) {
		
		
	
	
	if ([passCode isEqual:@""]) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"libPass" message:@"Please put a password into settings before using a libPass-enabled tweak" delegate:self cancelButtonTitle:@"Yes Sir!" otherButtonTitles:nil] autorelease];
		// optional - add more buttons:
		[alert show];
		[pool drain];
		[passCode release];
		enabled = YES;
	}
	
	if (enabled) {
		[(SBLockScreenManager *)[%c(SBLockScreenManager) sharedInstance] unlockUIFromSource:1 withOptions:nil];
		[pool drain];
	}
	
	if (!enabled) {
		isUsingAction = YES;
		[(SBLockScreenManager *)[%c(SBLockScreenManager) sharedInstance] _finishUIUnlockFromSource:1 withOptions:nil];
		[pool drain];
	}
		[pool drain];
		}
	else if (!fileExists){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"libPass" message:@"Please put a password into settings before using a libPass-enabled tweak" delegate:self cancelButtonTitle:@"Yes Sir!" otherButtonTitles:nil];
		// optional - add more buttons:
		[alert show];
		[alert release];
		enabled = YES;
		[pool drain];
		
	}
	
}

+ (BOOL)isPasscodeForced {
    return isPasscodeForced;
}
+(void)respringAfterDelay:(int)seconds {
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		system("killall backboardd");
	});
	
}

+ (void)setIsPasscodeForced:(BOOL)value {
	isPasscodeForced = value;
}



@end
