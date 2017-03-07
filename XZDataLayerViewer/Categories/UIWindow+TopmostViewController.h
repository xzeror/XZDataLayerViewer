//
//  UIWindow+TopmostViewController.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (TopmostViewController)
+ (UIViewController*)topmostViewControllerOfWindow:(UIWindow*)window;
@end
