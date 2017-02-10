//
//  EventHistoryDataSource.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@import UIKit;
@import ObjectiveC;
#import "EventHistoryDataSource.h"
#import "EventHistoryElement.h"
#import "ViewModel.h"

static IMP __original_Push_Imp;

void __swizzle_Push(id self, SEL _cmd, NSDictionary *dict)
{
	NSLog(@"%@, %@", self, NSStringFromSelector(_cmd));
	assert([NSStringFromSelector(_cmd) isEqualToString:@"push:"]);
	((void(*)(id,SEL,NSDictionary*))__original_Push_Imp)(self, _cmd, dict);
	[[NSNotificationCenter defaultCenter] postNotificationName:@"DataLayerHasChanged" object:nil];
}

@interface EventHistoryDataSource ()
/**
 *  Contains 100 copies of TAGDataLayer objects that saved with each change
 */
@property(nonatomic,strong)NSMutableArray *dataLayerHistory;
@property(nonatomic,strong)TAGDataLayer *dataLayer;
@end

@implementation EventHistoryDataSource
- (instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer{
	self = [super init];
	if (self != nil) {
		_dataLayerHistory = [NSMutableArray arrayWithCapacity:100];
		_dataLayer = dataLayer;
		
		Method m = class_getInstanceMethod([dataLayer class], @selector(push:));
		__original_Push_Imp = method_setImplementation(m,(IMP)__swizzle_Push);
		
		[[NSNotificationCenter defaultCenter] addObserverForName:@"DataLayerHasChanged" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
			NSLog(@"dataLayerHasChanged");
			NSDictionary *dataLayerModel = (NSDictionary*)[(id)dataLayer valueForKey:@"model"];
			EventHistoryElement *eventHistoryElement = [[EventHistoryElement alloc] initWithDataLayerModel:dataLayerModel];
			if (eventHistoryElement) {
				[_dataLayerHistory addObject:eventHistoryElement];
			}
		}];
	}
	return self;
}

- (void)dealloc{
	
}

- (NSInteger)count{
	return self.dataLayerHistory.count;
}

- (ViewModel*)viewModelForIndexPath:(NSIndexPath*)indexPath{
	if (indexPath.row >= self.dataLayerHistory.count) {
		return nil;
	}
	EventHistoryElement *eventHistoryElement = [self.dataLayerHistory objectAtIndex:indexPath.row];
	ViewModel *viewModel = [[ViewModel alloc] initWithKey:[eventHistoryElement.timestamp description]  value:nil shouldShowDisclosureIndicator:YES];
	return viewModel;
}

- (id)rawDataForIndexPath:(NSIndexPath*)indexPath{
	if (indexPath.row >= self.dataLayerHistory.count) {
		return nil;
	}
	EventHistoryElement *eventHistoryElement = [self.dataLayerHistory objectAtIndex:indexPath.row];
	NSDictionary *dataLayerModel = eventHistoryElement.dataLayerModel;
	return dataLayerModel;
}
@end
