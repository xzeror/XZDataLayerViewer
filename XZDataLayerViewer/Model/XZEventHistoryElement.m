//
//  EventHistoryElement.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "XZEventHistoryElement.h"
@interface XZEventHistoryElement ()
@property(nonatomic,strong)id<NSObject,NSCopying,NSCoding> data;
@property(nonatomic,strong)NSDate *timestamp;
@end

@implementation XZEventHistoryElement
- (instancetype)initWithData:(id<NSObject,NSCopying,NSCoding>)data{
	self = [super init];
	if ([data conformsToProtocol:@protocol(NSCoding)] == NO) {
		return nil;
	}
	if (self != nil) {
		_data = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:data]];
		_timestamp = [NSDate date];
	}
	return self;
}
@end
