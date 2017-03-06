//
//  UIWindow+TopmostViewController.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "UIWindow+TopmostViewController.h"

@implementation UIWindow (TopmostViewController)
+ (UIViewController*)topmostViewControllerOfWindow:(UIWindow*)window{
	UIViewController *topController = window.rootViewController;
	
	while (topController.presentedViewController) {
		topController = topController.presentedViewController;
	}
	
	return topController;
}
@end
