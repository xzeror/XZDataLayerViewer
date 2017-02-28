//
//  DataLayerObserver.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <objc/runtime.h>
#import "DataLayerObserver.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"
#import "TAGDataLayer+CustomProperties.h"

NSString * const DataLayerHasChangedNotification = @"com.xzonesoftware.datalayer.haschanged";
NSString * const kDataLayerPayload = @"com.xzonesoftware.datalayer.haschanged.datalayer_payload";

static IMP __original_Push_Implementation;

static void __swizzle_Push(id self, SEL _cmd, NSDictionary *dict)
{
	NSLog(@"%@, %@", self, NSStringFromSelector(_cmd));
	assert([NSStringFromSelector(_cmd) isEqualToString:@"push:"]);
	((void(*)(id,SEL,NSDictionary*))__original_Push_Implementation)(self, _cmd, dict);
	NSDictionary *dataLayerModel = (NSDictionary*)[self valueForKey:@"model"];
	NSDictionary *dataLayerModelDeepCopy = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:dataLayerModel]];
	[[NSNotificationCenter defaultCenter] postNotificationName:DataLayerHasChangedNotification object:self userInfo:@{kDataLayerPayload:dataLayerModelDeepCopy}];
}

@interface DataLayerObserver ()
@property(nonatomic,weak)TAGDataLayer *dataLayer;
@end

@implementation DataLayerObserver
- (instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer{
	NSParameterAssert(dataLayer);
	
	if((self = [super init])){
		_dataLayer = dataLayer;
		[self setupSwizzling];
	}
	return self;
}

- (void)dealloc{
	[self teardownSwizzling];
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

@end
