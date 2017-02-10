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

static const NSUInteger HistoryCount = 100;
static NSString * const DataLayerHasChangedNotification = @"com.xzonesoftware.datalayer.haschanged";

static IMP __original_Push_Imp;

void __swizzle_Push(id self, SEL _cmd, NSDictionary *dict)
{
	NSLog(@"%@, %@", self, NSStringFromSelector(_cmd));
	assert([NSStringFromSelector(_cmd) isEqualToString:@"push:"]);
	((void(*)(id,SEL,NSDictionary*))__original_Push_Imp)(self, _cmd, dict);
	[[NSNotificationCenter defaultCenter] postNotificationName:DataLayerHasChangedNotification object:nil];
}

@interface EventHistoryDataSource ()
/**
 *  Contains HistoryCount copies of TAGDataLayer objects that saved with each change
 */
@property(nonatomic,strong)NSMutableArray *dataLayerHistory;
@property(nonatomic,strong)TAGDataLayer *dataLayer;
@end

@implementation EventHistoryDataSource
- (instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer{
	self = [super init];
	if (self != nil) {
		_dataLayerHistory = [NSMutableArray arrayWithCapacity:HistoryCount];
		_dataLayer = dataLayer;
		
		Method m = class_getInstanceMethod([_dataLayer class], @selector(push:));
		__original_Push_Imp = method_setImplementation(m,(IMP)__swizzle_Push);
		
		[[NSNotificationCenter defaultCenter] addObserverForName:DataLayerHasChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
			NSLog(@"dataLayerHasChanged");
			NSDictionary *dataLayerModel = (NSDictionary*)[(id)_dataLayer valueForKey:@"model"];
			EventHistoryElement *eventHistoryElement = [[EventHistoryElement alloc] initWithDataLayerModel:dataLayerModel];
			if (eventHistoryElement) {
				if (self.dataLayerHistory.count >= HistoryCount) {
					[self.dataLayerHistory removeObject:self.dataLayerHistory.firstObject];
				}
				[_dataLayerHistory addObject:eventHistoryElement];
			}
		}];
	}
	return self;
}

- (void)dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:DataLayerHasChangedNotification object:nil];
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
