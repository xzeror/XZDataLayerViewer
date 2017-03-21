//
//  XZDataLayerViewer - XZDataLayerObserverTest.m
//  Copyright 2017 Andrey Ostanin. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZDataLayerObserver.h"

// Collaborators
#import "TAGDataLayer.h"
@interface XZDataLayerObserverTest : XCTestCase
@property(nonatomic,strong)id dataLayerMock;
@property(nonatomic,strong)XZDataLayerObserver *observer;
@end

@interface XZDataLayerObserverSwizzlingTest : XCTestCase
@property(nonatomic,strong)id dataLayerMock;
@end

@implementation XZDataLayerObserverTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.dataLayerMock = OCMClassMock([TAGDataLayer class]);
	self.observer = [[XZDataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
}

- (void)tearDown {
	self.dataLayerMock = nil;
	self.observer = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Tests
- (void)testInitWithNilAsserts{
	expect(^{XZDataLayerObserver *observer __attribute((unused)) = [[XZDataLayerObserver alloc] initWithDataLayer:nil];}).to.raiseAny();
}

- (void)testInitShouldSaveDataLayerInProperty{
	XZDataLayerObserver *observer = [[XZDataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
	expect(observer.dataLayer == self.dataLayerMock).to.beTruthy();
}

- (void)testAddObserverShouldAddSuppliedBlockToObserversArray{
	// given
	
	XZEventObservingBlock observingBlock = [self emptyObservingBlock];
	
	// when
	[self.observer addObserver:observingBlock];
	
	// then
	expect(self.observer.observers).to.contain(observingBlock);
}

- (void)testAddObserverShouldReturnNonNilIdForRemoveObserverMethod{
	// given
	XZEventObservingBlock observingBlock = [self emptyObservingBlock];
	
	// when
	id observerId = [self.observer addObserver:observingBlock];
	
	// then
	expect(observerId).toNot.beNil();
}

- (void)testRemoveObserverShouldRemoveObservingBlockFromObserversList{
	// given
	XZEventObservingBlock observingBlock = [self emptyObservingBlock];
	NSUInteger initialObserversCount = self.observer.observers.count;
	
	// when
	id observerId = [self.observer addObserver:observingBlock];
	[self.observer removeObserver:observerId];
	
	// then
	expect(initialObserversCount).equal(self.observer.observers.count);
}

- (void)testSwizzledPushMethodGeneratesEventsAndCallsObservers{
	// given
	NSDictionary *dictionaryMock = OCMClassMock([NSDictionary class]);
	TAGDataLayer *dataLayer = [[TAGDataLayer alloc] init];
	XZDataLayerObserver *observer __attribute((unused)) = [[XZDataLayerObserver alloc] initWithDataLayer:dataLayer];
	XCTestExpectation *expectation = [self expectationWithDescription:@"Expect observer block would be called"];
	XZEventObservingBlock observingBlock = ^(id<NSObject,NSCoding,NSCopying> eventData){
		[expectation fulfill];
	};
	[observer addObserver:observingBlock];
	
	// when
	[dataLayer push:dictionaryMock];
	
	// then
	[self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
		expect(error).to.beNil();
	}];
}

#pragma mark Helpers
- (XZEventObservingBlock)emptyObservingBlock{
	return ^(id<NSObject,NSCoding,NSCopying> eventData){};
}

@end

@implementation XZDataLayerObserverSwizzlingTest
- (void)setUp {
	[super setUp]; // must be the first line in method
	self.dataLayerMock = OCMClassMock([TAGDataLayer class]);
}

- (void)tearDown {
	self.dataLayerMock = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Tests

- (void)testInitSwizzlesDataLayerPushMethod{
	// given
	Method originalMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP originalImplementation = method_getImplementation(originalMethod);
	
	// when
	XZDataLayerObserver *observer __attribute((unused)) = [[XZDataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
	Method swizzledMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP swizzledImplementation = method_getImplementation(swizzledMethod);
	
	// then
	expect(originalImplementation != swizzledImplementation).to.beTruthy();
}

- (void)testDeallocShouldRevertSwizzlingOfDataLayerPushMethod{
	// given
	Method originalMethod = class_getInstanceMethod([self.dataLayerMock class], @selector(push:));
	IMP originalImplementation = method_getImplementation(originalMethod);
	__weak XZDataLayerObserver *weakObserver = nil;
	
	// when
	@autoreleasepool {
		XZDataLayerObserver *observer = [[XZDataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
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
	__weak XZDataLayerObserver *weakObserver1 = nil;
	__weak XZDataLayerObserver *weakObserver2 = nil;
	
	// when
	@autoreleasepool {
		XZDataLayerObserver *observer1 = [[XZDataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
		XZDataLayerObserver *observer2 = [[XZDataLayerObserver alloc] initWithDataLayer:self.dataLayerMock];
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
@end
