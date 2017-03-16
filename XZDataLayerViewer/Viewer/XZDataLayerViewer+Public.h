//  Created by Andrey Ostanin on 13.03.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "Common.h"

@class TAGManager;
@protocol XZStoreProtocol;
@protocol XZEventGeneratorProtocol;

@interface XZDataLayerViewer : NSObject
/**
 *  Configure data layer viewer component
 *	
 *  Before component can be used it must be configured with appropriate classes.
 *
 *  @param tagManager      TAGManager instance object [TAGManager sharedInstance]
 *  @param store           store that would be used for saving states of data layer, should be an NSObject descendant and conform to XZStoreProtocol
 *  @param eventGenerator  event generator that triggers state saving, should be an NSObject descendant and conform to XZEventGeneratorProtocol
 *  @param maxHistoryItems maximum desired number of elements available in store
 */
+ (void)configureWithTagManger:(TAGManager*)tagManager store:(Class)store eventGenerator:(Class)eventGenerator maxHistoryItems:(NSUInteger)maxHistoryItems;

/**
 *  Singletone shared instance
 *
 *  @return XZDataLayerViewer shared instance
 */
+ (instancetype)sharedInstance;

/**
 *  Viewer interface that could be shown in your app
 *
 *  @return UIViewController object
 */
- (UIViewController*)viewerInterface;
@end
