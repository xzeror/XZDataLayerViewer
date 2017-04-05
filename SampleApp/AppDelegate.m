//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "AppDelegate.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"
#import "XZDataLayerViewer.h"

static NSString *GTMContainerId = @"GTM-AAABBB";
static NSUInteger counter = 0;

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self setupTagManager];
	[self setupDataLayerViewer];
	[self setupWindow];
	[self setupRootViewController];
	[self setupDataLayerPushEmulationWithTimer];
	[self showDataLayerViewer];
	return YES;
}
- (void)setupTagManager{
	[[[TAGManager instance] logger] setLogLevel:kTAGLoggerLogLevelVerbose];
	[[TAGManager instance] openContainerById:GTMContainerId callback:nil];
}

- (void)setupDataLayerViewer{
	[XZDataLayerViewer configureWithTagManger:[TAGManager instance] store:XZDefaultStore eventGenerator:XZDefaultObserver maxHistoryItems:100];
}

- (void)setupWindow{
	UIViewController *rootViewController = [[UIViewController alloc] init];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = rootViewController;
	[self.window makeKeyAndVisible];
}

- (void)setupRootViewController{
	self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[self.window.rootViewController.view addSubview:button];
	[button addTarget:self action:@selector(showDataLayerViewer) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupDataLayerPushEmulationWithTimer{
	NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1] interval:1 target:self selector:@selector(pushData) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)showDataLayerViewer{
	UIViewController *dataLayerViewerInterface = [[XZDataLayerViewer sharedInstance] viewerInterface];
	[self.window.rootViewController presentViewController:dataLayerViewerInterface animated:YES completion:nil];
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
@end
