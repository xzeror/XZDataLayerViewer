//
//  HistoryDataSource.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZHistoryDataSource.h"
#import "XZEventHistoryElement.h"
#import "XZViewModel.h"
#import "XZStoreProtocol.h"

@interface XZHistoryDataSource ()
@property(nonatomic,strong)id<XZStoreProtocol> store;
@end

@implementation XZHistoryDataSource
- (instancetype)initWithStore:(id<XZStoreProtocol>)store{
	if ((self = [super init])) {
		_store = store;
	}
	return self;
}

- (NSInteger)count{
	return [self.store objectsCount];
}

- (XZViewModel*)viewModelForIndexPath:(NSIndexPath*)indexPath{
	if (indexPath.row >= [self.store objectsCount]) {
		return nil;
	}
	XZEventHistoryElement *eventHistoryElement = [self.store objectWithId:@(indexPath.row)];
	XZViewModel *viewModel = [[XZViewModel alloc] initWithKey:[eventHistoryElement.timestamp description]  value:nil shouldShowDisclosureIndicator:YES];
	return viewModel;
}

- (id)rawDataForIndexPath:(NSIndexPath*)indexPath{
	if (indexPath.row >= [self.store objectsCount]) {
		return nil;
	}
	XZEventHistoryElement *eventHistoryElement = [self.store objectWithId:@(indexPath.row)];
	id data = eventHistoryElement.data;
	return data;
}
@end
