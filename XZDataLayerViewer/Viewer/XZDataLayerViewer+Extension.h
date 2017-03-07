//
//  XZDataLayerViewer+Private.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@class DataLayerObserver;
@class DataLayerHistoryWriter;
@protocol StoreProtocol;

@interface XZDataLayerViewer ()
@property(nonatomic,strong)DataLayerObserver *observer;
@property(nonatomic,strong)DataLayerHistoryWriter *writer;
@property(nonatomic,strong)id<StoreProtocol> store;
@property(nonatomic,weak)id<UIApplicationDelegate> appDelegate;
- (instancetype)initWithStore:(id<StoreProtocol>)store
					   writer:(DataLayerHistoryWriter*)writer
			dataLayerObserver:(DataLayerObserver*)observer
		  applicationDelegate:(id<UIApplicationDelegate>)appDelegate;
@end
