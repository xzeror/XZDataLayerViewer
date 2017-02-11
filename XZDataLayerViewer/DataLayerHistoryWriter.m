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

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface DataLayerHistoryWriter ()
@property(nonatomic,strong)id<StoreProtocol> store;
@end

@implementation DataLayerHistoryWriter
- (instancetype)initWithStore:(id<StoreProtocol>)store{
	if((self = [super init])){
		_store = store;
		
		[self setupDataLayerObservation];
	}
	return self;
}

-(void)dealloc{
	if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
		[self tearDownDataLayerObservation];
	}
}

#pragma mark - Auxiliary methods
- (void)setupDataLayerObservation{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(writeDataLayerCopyToStore:) name:DataLayerHasChangedNotification object:nil];
}

- (void)tearDownDataLayerObservation{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:DataLayerHasChangedNotification object:nil];
}

- (void)writeDataLayerCopyToStore:(NSNotification*)notification{
	NSDictionary *dataLayerModel = notification.userInfo[kDataLayerPayload];
	EventHistoryElement *eventHistoryElement = [[EventHistoryElement alloc] initWithDataLayerModel:dataLayerModel];
	if (eventHistoryElement == nil) {
		return;
	}
	[self.store addObject:eventHistoryElement];
}

@end
