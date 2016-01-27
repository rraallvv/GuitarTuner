#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	_audioController = [[PdAudioController alloc] init];
	if ([self.audioController configurePlaybackWithSampleRate:44100
											   numberChannels:2
												 inputEnabled:YES
												mixingEnabled:NO] != PdAudioOK) {
		NSLog(@"failed to initialize audio components");
	}
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	self.audioController.active = NO;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	self.audioController.active = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
