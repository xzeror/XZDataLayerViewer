//
//  ArrayDataSource.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@import UIKit;
#import "ArrayDataSource.h"
#import "ViewModel.h"

@interface ArrayDataSource ()
@property(nonatomic,strong)NSArray *data;
@end

@implementation ArrayDataSource
- (instancetype)initWithArray:(NSArray*)array{
	self = [super init];
	if(self != nil){
		_data = array;
	}
	return self;
}


- (NSInteger)count{
	return self.data.count;
}

- (ViewModel*)viewModelForIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row >= self.data.count) {
		return nil;
	}
	
	ViewModel *viewModel = nil;
	id value = [self.data objectAtIndex:indexPath.row];
	BOOL shouldShowDisclosuerIndicator = ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) ? YES : NO;
	
	if (shouldShowDisclosuerIndicator) {
		viewModel = [[ViewModel alloc] initWithKey:@(indexPath.row).stringValue value:nil shouldShowDisclosureIndicator:shouldShowDisclosuerIndicator];
	}
	else{
		NSString *valueString = [value description];
		viewModel = [[ViewModel alloc] initWithKey:@(indexPath.row).stringValue value:valueString shouldShowDisclosureIndicator:shouldShowDisclosuerIndicator];
	}
	return viewModel;
}

- (id)rawDataForIndexPath:(NSIndexPath*)indexPath{
	id value = [self.data objectAtIndex:indexPath.row];
	return value;
}

@end
