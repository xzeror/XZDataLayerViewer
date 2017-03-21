//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZEventGeneratorProtocol.h"
#import "XZDataLayerViewer+Public.h"

@protocol XZStoreProtocol;
@protocol XZStoreWriterProtocol;
@protocol XZEventGeneratorProtocol;


@interface XZDataLayerViewer ()
/**
 *  Event generator object that triggers write to store
 */
@property(nonatomic,strong)id<XZEventGeneratorProtocol> eventGenerator;

/**
 *  Writer is an object that writes information to store.
 */
@property(nonatomic,strong)id<XZStoreWriterProtocol> writer;

/**
 *  Store is an object that stores information and allows to retrive it back
 */
@property(nonatomic,strong)id<XZStoreProtocol> store;

/**
 *  Block that executes when write even it triggered
 */
@property(nonatomic,copy,readonly)XZEventObservingBlock observerBlock;

/**
 *  Init instance with main working components
 *
 *  @param store          store is an object that stores information and allows to retrive it back
 *  @param writer         writer is an object that writes information to store.
 *  @param eventGenerator event generator object that triggers write to store
 *
 *  @return instance of XZDataLayerViewer
 */
- (instancetype)initWithStore:(id<XZStoreProtocol>)store
					   writer:(id<XZStoreWriterProtocol>)writer
			dataLayerObserver:(id<XZEventGeneratorProtocol>)eventGenerator;
@end
