//
//  HistoryDataSource.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryDataSource.h"
#import "EventHistoryElement.h"
#import "ViewModel.h"
#import "StoreProtocol.h"

@interface HistoryDataSource ()
@property(nonatomic,strong)id<StoreProtocol> store;
@end

@implementation HistoryDataSource
- (instancetype)initWithStore:(id<StoreProtocol>)store{
	if ((self = [super init])) {
		_store = store;
	}
	return self;
}

- (NSInteger)count{
	return [self.store objectsCount];
}

- (ViewModel*)viewModelForIndexPath:(NSIndexPath*)indexPath{
	if (indexPath.row >= [self.store objectsCount]) {
		return nil;
	}
	EventHistoryElement *eventHistoryElement = [self.store objectWithId:@(indexPath.row)];
	ViewModel *viewModel = [[ViewModel alloc] initWithKey:[eventHistoryElement.timestamp description]  value:nil shouldShowDisclosureIndicator:YES];
	return viewModel;
}

- (id)rawDataForIndexPath:(NSIndexPath*)indexPath{
	if (indexPath.row >= [self.store objectsCount]) {
		return nil;
	}
	EventHistoryElement *eventHistoryElement = [self.store objectWithId:@(indexPath.row)];
	NSDictionary *dataLayerModel = eventHistoryElement.dataLayerModel;
	return dataLayerModel;
}
@end
