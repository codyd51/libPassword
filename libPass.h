#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <substrate.h>
//#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>

BOOL isUsingAction = NO;
BOOL hasShownAlert = NO;
BOOL isFirstUnlock = YES;
BOOL tweakEnabled = NO;
static BOOL isPasscodeForced = YES;
//NSString *passCode = nil;





@interface SBDeviceLockController
- (BOOL)attemptDeviceUnlockWithPassword:(id)fp8 appRequested:(BOOL)fp12;
@end
@interface SBLockScreenManager
- (BOOL)attemptUnlockWithPasscode:(id)fp8;
- (void)_finishUIUnlockFromSource:(int)fp8 withOptions:(id)fp12;
- (void)unlockUIFromSource:(int)fp8 withOptions:(id)fp12;
@end

@interface SpringBoard
- (void)relaunchSpringBoard;
@end

@interface DevicePINController

- (void)setOldPassword:(id)arg1;

@end



@interface libPass : NSObject {}

+ (BOOL)isPasscodeForced;
+ (void)setIsPasscodeForced:(BOOL)value;

+(void)unlockWithCodeEnabled:(BOOL)enabled;
+(void)respringAfterDelay:(int)seconds;
//@property (nonatomic) BOOL isPasscodeForced;
@end



