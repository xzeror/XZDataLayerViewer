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

NSString * const DataLayerHasChangedNotification = @"com.xzonesoftware.datalayer.haschanged";
NSString * const kDataLayerPayload = @"com.xzonesoftware.datalayer.haschanged.datalayer_payload";

static NSString * const DataLayerModelPropertyName = @"model";

static IMP __original_Push_Imp;

void __swizzle_Push(id self, SEL _cmd, NSDictionary *dict)
{
	NSLog(@"%@, %@", self, NSStringFromSelector(_cmd));
	assert([NSStringFromSelector(_cmd) isEqualToString:@"push:"]);
	((void(*)(id,SEL,NSDictionary*))__original_Push_Imp)(self, _cmd, dict);
	NSDictionary *dataLayerModel = (NSDictionary*)[self valueForKey:DataLayerModelPropertyName];
	NSDictionary *dataLayerCopy = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:dataLayerModel]];
	[[NSNotificationCenter defaultCenter] postNotificationName:DataLayerHasChangedNotification object:self userInfo:@{kDataLayerPayload:dataLayerCopy}];
}

@interface DataLayerObserver ()
@property(nonatomic,weak)TAGDataLayer *dataLayer;
@end

@implementation DataLayerObserver
- (instancetype)init{
	return [self initWithDataLayer:nil];
}

- (instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer{
	NSParameterAssert(dataLayer);
	
	if((self = [super init])){
		_dataLayer = dataLayer;
		Method m = class_getInstanceMethod([_dataLayer class], @selector(push:));
		__original_Push_Imp = method_setImplementation(m,(IMP)__swizzle_Push);
	}
	return self;
}

- (void)dealloc{
	if (_dataLayer == nil) {
		return;
	}
	Method m = class_getInstanceMethod([_dataLayer class], @selector(push:));
	method_setImplementation(m,(IMP)__original_Push_Imp);
}

@end
