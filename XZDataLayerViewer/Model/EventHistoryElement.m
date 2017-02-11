//
//  EventHistoryElement.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "EventHistoryElement.h"
@interface EventHistoryElement ()
@property(nonatomic,strong)NSDictionary *dataLayerModel;
@property(nonatomic,strong)NSDate *timestamp;
@end

@implementation EventHistoryElement
- (instancetype)initWithDataLayerModel:(NSDictionary*)dataLayerModel{
	self = [super init];
	if (self != nil) {
		_dataLayerModel = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:dataLayerModel]];
		_timestamp = [NSDate date];
	}
	return self;
}
@end
