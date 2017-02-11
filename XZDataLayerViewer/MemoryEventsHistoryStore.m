//
//  MemoryEventsHistoryStore.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "MemoryEventsHistoryStore.h"

static const NSUInteger DefaultHistoryLimit = 100;

@interface MemoryEventsHistoryStore ()
@property(nonatomic,strong)NSMutableArray *store;
- (instancetype)initWithHistoryLimit:(NSUInteger)historyLimit NS_DESIGNATED_INITIALIZER;
@end

@implementation MemoryEventsHistoryStore
@synthesize historyLimit = _historyLimit;
- (instancetype)init{
	return [self initWithHistoryLimit:DefaultHistoryLimit];
}

- (instancetype)initWithHistoryLimit:(NSUInteger)historyLimit{
	if ((self = [super init])) {
		_historyLimit = historyLimit;
		_store = [[NSMutableArray alloc] initWithCapacity:_historyLimit];
	}
	return self;
}

- (void)addObject:(id)object{
	[self.store addObject:object];
	if (self.store.count >= self.historyLimit) {
		[self.store removeObject:self.store.firstObject];
	}
}

- (id)objectWithId:(id)identifier{
	if ([identifier isKindOfClass:[NSNumber class]] == NO) {
		return nil;
	}
	return [self.store objectAtIndex:[identifier unsignedIntegerValue]];
}

- (NSUInteger)objectsCount{
	return self.store.count;
}

- (NSArray*)objects{
	return self.store;
}

- (void)setHistoryLimit:(NSUInteger)historyLimit{
	if (_historyLimit == historyLimit) {
		return;
	}
	
	if (historyLimit < _historyLimit) {
		self.store = [[self.store subarrayWithRange:NSMakeRange(0, historyLimit - _historyLimit - 1)] mutableCopy];
	}
	_historyLimit = historyLimit;
}

@end
