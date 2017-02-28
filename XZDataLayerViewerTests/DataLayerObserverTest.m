//
//  XZDataLayerViewer - DataLayerObserverTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "DataLayerObserver.h"

// Collaborators
#import "TAGDataLayer.h"

@interface DataLayerObserverTest : XCTestCase
@property(nonatomic,strong)id dataLayerMock;
@end


@implementation DataLayerObserverTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.dataLayerMock = OCMClassMock([TAGDataLayer class]);
}

- (void)tearDown {
	self.dataLayerMock = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testInitWithNilAsserts{
	expect(^{DataLayerObserver *observer __attribute((unused)) = [[DataLayerObserver alloc] initWithDataLayer:nil];}).to.raiseAny();
}

- (void)testInitShouldSaveDataLayerInProperty{
	DataLayerObserver *observer = [[DataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
	expect(observer.dataLayer == self.dataLayerMock).to.beTruthy();
}

- (void)testInitSwizzlesDataLayerPushMethod{
	// given
	Method originalMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP originalImplementation = method_getImplementation(originalMethod);
	
	// when
	DataLayerObserver *observer __attribute((unused)) = [[DataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
	Method swizzledMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP swizzledImplementation = method_getImplementation(swizzledMethod);
	
	// then
	expect(originalImplementation != swizzledImplementation).to.beTruthy();
}

- (void)testDeallocShouldRevertSwizzlingOfDataLayerPushMethod{
	// given
	Method originalMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP originalImplementation = method_getImplementation(originalMethod);
	__weak DataLayerObserver *weakObserver = nil;
	
	// when
	@autoreleasepool {
		DataLayerObserver *observer = [[DataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
		weakObserver = observer;
	}
	Method swizzledMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP swizzledImplementation = method_getImplementation(swizzledMethod);
	
	// then
	expect(weakObserver).to.beNil;
	expect(originalImplementation == swizzledImplementation).to.beTruthy();
}

- (void)testCreatingSeveralObserversDoesNotRewriteSwizzlingImplementation{
	// given
	Method originalMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP originalImplementation = method_getImplementation(originalMethod);
	__weak DataLayerObserver *weakObserver1 = nil;
	__weak DataLayerObserver *weakObserver2 = nil;
	
	// when
	@autoreleasepool {
		DataLayerObserver *observer1 = [[DataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
		DataLayerObserver *observer2 = [[DataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
		weakObserver1 = observer1;
		weakObserver2 = observer2;
	}
	Method swizzledMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP swizzledImplementation = method_getImplementation(swizzledMethod);
	
	// then
	expect(weakObserver1).to.beNil;
	expect(weakObserver2).to.beNil;
	expect(originalImplementation == swizzledImplementation).to.beTruthy();
}

- (void)testSwizzledPushMethodGeneratesNotifications{
	// given
	NSDictionary *dictionaryMock = OCMClassMock([NSDictionary class]);
	TAGDataLayer *dataLayer = [[TAGDataLayer alloc] init];
	DataLayerObserver *observer __attribute((unused)) = [[DataLayerObserver alloc] initWithDataLayer:dataLayer];
	
	XCTestExpectation *expectation __attribute((unused)) = [self expectationForNotification:DataLayerHasChangedNotification object:dataLayer handler:^BOOL(NSNotification * _Nonnull notification) {
		expect(notification.userInfo).toNot.beNil();
		expect(notification.userInfo[kDataLayerPayload]).toNot.beNil();
		expect(notification.userInfo[kDataLayerPayload]).equal(dictionaryMock);
		return YES;
	}];
	
	// when
	[dataLayer push:dictionaryMock];
	
	// then
	[self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
		expect(error).to.beNil();
	}];
}

@end
