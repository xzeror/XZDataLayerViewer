//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZDictionaryDataSource.h"
#import "XZViewModel.h"

@interface XZDictionaryDataSource ()
@property(nonatomic,strong)NSDictionary *data;
@end

@implementation XZDictionaryDataSource
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

- (XZViewModel*)viewModelForIndexPath:(NSIndexPath *)indexPath{
	XZViewModel *viewModel = nil;
	NSArray *sortedDataKeys = [self sortedDataKeys];
	
	if (indexPath.row >= sortedDataKeys.count) {
		return nil;
	}
	
	NSString *key = [sortedDataKeys objectAtIndex:indexPath.row];
	id value = [self.data objectForKey:key];
	BOOL shouldShowDisclosuerIndicator = ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) ? YES : NO;
	
	if (shouldShowDisclosuerIndicator) {
		viewModel = [[XZViewModel alloc] initWithKey:key value:nil shouldShowDisclosureIndicator:shouldShowDisclosuerIndicator];
	}
	else{
		viewModel = [[XZViewModel alloc] initWithKey:key value:[value description] shouldShowDisclosureIndicator:shouldShowDisclosuerIndicator];
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
