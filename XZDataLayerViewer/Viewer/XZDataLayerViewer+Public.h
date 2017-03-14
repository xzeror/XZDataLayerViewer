//
//  XZDataLayerViewer+Public.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 13.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "Common.h"

@class TAGManager;
@protocol XZStoreProtocol;
@protocol XZEventGeneratorProtocol;

@interface XZDataLayerViewer : NSObject
+ (void)configureWithTagManger:(TAGManager*)tagManager store:(Class<XZStoreProtocol>)store eventGenerator:(Class<XZEventGeneratorProtocol>)eventGenerator maxHistoryItems:(NSUInteger)maxHistoryItems;
+ (instancetype)sharedInstance;
- (UIViewController*)viewerInterface;
@end
