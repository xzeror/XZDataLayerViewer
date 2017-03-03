//
//  DictionaryDataSource.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryDataSource.h"
#import "ViewModel.h"

@interface DictionaryDataSource ()
@property(nonatomic,strong)NSDictionary *data;
@end

@implementation DictionaryDataSource
- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
	self = [super init];
	if(self != nil){
		_data = dictionary;
	}
	return self;
}

- (NSInteger)count{
	return self.data.count;
}

- (ViewModel*)viewModelForIndexPath:(NSIndexPath *)indexPath{
	ViewModel *viewModel = nil;
	NSArray *sortedDataKeys = [self sortedDataKeys];
	
	if (indexPath.row >= sortedDataKeys.count) {
		return nil;
	}
	
	NSString *key = [sortedDataKeys objectAtIndex:indexPath.row];
	id value = [self.data objectForKey:key];
	BOOL shouldShowDisclosuerIndicator = ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) ? YES : NO;
	
	if (shouldShowDisclosuerIndicator) {
		viewModel = [[ViewModel alloc] initWithKey:key value:nil shouldShowDisclosureIndicator:shouldShowDisclosuerIndicator];
	}
	else{
		viewModel = [[ViewModel alloc] initWithKey:key value:[value description] shouldShowDisclosureIndicator:shouldShowDisclosuerIndicator];
	}
	return viewModel;
}

- (id)rawDataForIndexPath:(NSIndexPath*)indexPath{
	NSArray *sortedDataKeys = [self sortedDataKeys];
	if (indexPath.row >= sortedDataKeys.count) {
		return nil;
	}
	NSString *key = [sortedDataKeys objectAtIndex:indexPath.row];
	id value = [self.data objectForKey:key];
	return value;
}

- (NSArray*)sortedDataKeys{
	NSArray *retValue = [self.data.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *key1, NSString *key2) {
		return [key1 caseInsensitiveCompare:key2];
	}];
	return retValue;
}

@end
