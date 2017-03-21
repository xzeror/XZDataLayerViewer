//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "AppDelegate.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"
#import "XZDataLayerViewer.h"


static NSString *GTMContainerId = @"GTM-AAABBB";
static NSUInteger counter = 0;

@interface AppDelegate ()
@end

@implementation AppDelegate

- (void)setupDataLayerViewer{
	[XZDataLayerViewer configureWithTagManger:[TAGManager instance] store:XZDefaultStore eventGenerator:XZDefaultObserver maxHistoryItems:100];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	[self setupTagManager];
	[self setupDataLayerViewer];
	
	UIViewController *rootViewController = [[UIViewController alloc] init];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = rootViewController;
	[self.window makeKeyAndVisible];
	
	UIViewController *dataLayerViewerInterface = [[XZDataLayerViewer sharedInstance] viewerInterface];
	[rootViewController presentViewController:dataLayerViewerInterface animated:YES completion:nil];
	
	
	NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1] interval:1 target:self selector:@selector(pushData) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	return YES;
}

- (void)pushData{
	NSDictionary *ecommerce = @{@"ecommerce": @{
										@"counter": @(counter),
										@"currencyCode": @"RUB",
										@"detail": @{
												@"products": @[
														@{@"name": @"alsdkjflkdsj fldskfj df",
														  @"id": @(123456),
														  @"price": @(123.23),
														  @"category": @"asdfsdf",
														  }
														]
												}
										}
								};
	
	[[TAGManager instance].dataLayer push:ecommerce];
	counter++;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupTagManager{
	[[[TAGManager instance] logger] setLogLevel:kTAGLoggerLogLevelVerbose];
	[[TAGManager instance] openContainerById:GTMContainerId callback:nil];
}
@end
