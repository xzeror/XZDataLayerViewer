//
//  DataLayerHistoryWriter.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataLayerHistoryWriter.h"
#import "DataLayerObserver.h"
#import "StoreProtocol.h"
#import "EventHistoryElement.h"
#import "UIDevice+SystemVersion.h"

@interface DataLayerHistoryWriter ()
@property(nonatomic,strong)id<StoreProtocol> store;
@property(nonatomic,strong)NSNotificationCenter *notificationCenter;
@property(nonatomic,strong)id notificationObserver;
@end

@implementation DataLayerHistoryWriter


- (instancetype)initWithStore:(id<StoreProtocol>)store notificationCenter:(NSNotificationCenter*)notificationCenter{
	if((self = [super init])){
		_store = store;
		_notificationCenter = notificationCenter;
		
		[self setupDataLayerObservation];
	}
	return self;
}

-(void)dealloc{
	[self tearDownDataLayerObservation];
}

#pragma mark - Auxiliary methods
- (void)setupDataLayerObservation{
	__weak typeof(self) weakSelf = self;
	self.notificationObserver = [self.notificationCenter addObserverForName:DataLayerHasChangedNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull notification) {
		typeof(weakSelf) strongSelf = weakSelf;
		NSDictionary *dataLayerModel = notification.userInfo[kDataLayerPayload];
		[strongSelf writeDataLayerCopyToStore:dataLayerModel];
	}];
}

- (void)tearDownDataLayerObservation{
	[self.notificationCenter removeObserver:_notificationObserver];
}

- (void)writeDataLayerCopyToStore:(NSDictionary*)dataLayerModel{
	EventHistoryElement *eventHistoryElement = [[EventHistoryElement alloc] initWithDataLayerModel:dataLayerModel];
	if (eventHistoryElement == nil) {
		return;
	}
	[self.store addObject:eventHistoryElement];
}

@end
