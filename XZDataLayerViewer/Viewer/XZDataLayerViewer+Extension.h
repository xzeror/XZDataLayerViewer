//
//  XZDataLayerViewer+Private.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "XZEventGeneratorProtocol.h"

@protocol XZStoreProtocol;
@protocol XZStoreWriterProtocol;
@protocol XZEventGeneratorProtocol;


@interface XZDataLayerViewer ()
@property(nonatomic,strong)id<XZEventGeneratorProtocol> eventGenerator;
@property(nonatomic,strong)id<XZStoreWriterProtocol> writer;
@property(nonatomic,strong)id<XZStoreProtocol> store;
@property(nonatomic,copy,readonly)XZEventObservingBlock observerBlock;
- (instancetype)initWithStore:(id<XZStoreProtocol>)store
					   writer:(id<XZStoreWriterProtocol>)writer
			dataLayerObserver:(id<XZEventGeneratorProtocol>)eventGenerator;
@end
