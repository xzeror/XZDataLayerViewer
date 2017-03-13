//
//  XZDataLayerViewer.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@protocol UIApplicationDelegate;
@class TAGManager;

@interface XZDataLayerViewer : NSObject
//TODO: we also need to give user store options. Later...
+ (void)configureWithTagManger:(TAGManager*)tagManager maxHistoryItems:(NSUInteger)maxHistoryItems;
+ (instancetype)sharedInstance;
- (UIViewController*)viewerInterface;
@end
