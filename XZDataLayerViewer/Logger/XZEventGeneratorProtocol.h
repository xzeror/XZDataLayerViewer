//
//  XZEventGenerator.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 07.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

typedef void (^XZEventObservingBlock)(id<NSObject,NSCoding,NSCopying> eventData);

@protocol XZEventGeneratorProtocol
@property(nonatomic,strong,readonly)NSArray *observers;
- (id)addObserver:(XZEventObservingBlock)observingBlock;
- (void)removeObserver:(id)observerId;
@end
