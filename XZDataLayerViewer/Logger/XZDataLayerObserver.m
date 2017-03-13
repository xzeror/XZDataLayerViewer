//
//  DataLayerObserver.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <objc/runtime.h>
#import "XZDataLayerObserver.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"
#import "TAGDataLayer+CustomProperties.h"

NSString * const DataLayerHasChangedNotification = @"com.xzonesoftware.datalayer.haschanged";
NSString * const kDataLayerPayload = @"com.xzonesoftware.datalayer.haschanged.datalayer_payload";

static IMP __original_Push_Implementation;
static NSMutableDictionary *observers;

static void __swizzle_Push(id self, SEL _cmd, NSDictionary *dict)
{
	NSLog(@"%@, %@", self, NSStringFromSelector(_cmd));
	assert([NSStringFromSelector(_cmd) isEqualToString:@"push:"]);
	((void(*)(id,SEL,NSDictionary*))__original_Push_Implementation)(self, _cmd, dict);
	NSDictionary *dataLayerModel = (NSDictionary*)[self valueForKey:@"model"];
	NSDictionary *dataLayerModelDeepCopy = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:dataLayerModel]];
	for (NSArray *observerObservers in [observers allValues]) {
		for (XZEventObservingBlock block in observerObservers) {
			block(dataLayerModelDeepCopy);
		}
	}
}

@interface XZDataLayerObserver ()
@property(nonatomic,weak)TAGDataLayer *dataLayer;
@end

@implementation XZDataLayerObserver
- (instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer{
	NSParameterAssert(dataLayer);
	self = [super init];
	if(!self){
		return nil;
	}
	static dispatch_once_t createObserversDictionaryOnlyOnce;
	dispatch_once(&createObserversDictionaryOnlyOnce, ^{
		observers = [[NSMutableDictionary alloc] initWithCapacity:1];
	});
	_dataLayer = dataLayer;
	[self setupSwizzling];
	return self;
}

- (void)dealloc{
	[self teardownSwizzling];
	[self removeMyObservers];
}

- (void)setupSwizzling{
	@synchronized (self) {
		if (__original_Push_Implementation) {
			// already swizzled, nothing to do
			return;
		}
		Method m = class_getInstanceMethod([_dataLayer class], @selector(push:));
		__original_Push_Implementation = method_setImplementation(m,(IMP)__swizzle_Push);
	}
}

- (void)teardownSwizzling{
	@synchronized (self) {
		Method m = class_getInstanceMethod([_dataLayer class], @selector(push:));
		method_setImplementation(m,(IMP)__original_Push_Implementation);
		__original_Push_Implementation = nil;
	}
}

- (NSArray*)observers{
	return [[self myObservers] copy];
}

- (id)addObserver:(XZEventObservingBlock)observingBlock{
	id blockCopy = [observingBlock copy];
	NSMutableArray *myObservers = [self myObservers];
	[myObservers addObject:blockCopy];
	return blockCopy;
}

- (void)removeObserver:(id)observerId{
	NSMutableArray *myObservers = [self myObservers];
	[myObservers removeObject:observerId];
}

- (NSMutableArray*)myObservers{
	NSMutableArray *myObservers = [observers objectForKey:[self entityUniqueKey]];
	if (myObservers == nil) {
		myObservers = [NSMutableArray arrayWithCapacity:1];
		[observers setObject:myObservers forKey:[self entityUniqueKey]];
	}
	return myObservers;
}

- (void)removeMyObservers{
	[observers removeObjectForKey:[self entityUniqueKey]];
}

- (id<NSCopying>)entityUniqueKey{
	return @([self hash]);
}

@end
