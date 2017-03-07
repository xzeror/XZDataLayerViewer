//
//  XZDataLayerViewer - XZDataLayerViewerTestTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZDataLayerViewer.h"
#import "XZDataLayerViewer+Extension.h"

// Collaborators
#import "MemoryEventsHistoryStore.h"
#import "DataLayerObserver.h"
#import "DataLayerHistoryWriter.h"
#import "ViewController.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"
#import "StoreProtocol.h"
#import "UIWindow+TopmostViewController.h"
#import "HistoryDataSource.h"

@interface XZDataLayerViewerTest : XCTestCase
@property(nonatomic,strong)XZDataLayerViewer *dataLayerViewer;
@property(nonatomic,strong)XZDataLayerViewer *dataLayerViewerPartialMock;
@property(nonatomic,strong)id<StoreProtocol> storeMock;
@property(nonatomic,strong)DataLayerObserver *dataLayerObserverMock;
@property(nonatomic,strong)DataLayerHistoryWriter *dataLayerHistoryWriterMock;
@property(nonatomic,strong)id<UIApplicationDelegate> appDelegate;
@end


@implementation XZDataLayerViewerTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.storeMock = OCMClassMock([MemoryEventsHistoryStore class]);
	self.dataLayerObserverMock = OCMClassMock([DataLayerObserver class]);
	self.dataLayerHistoryWriterMock = OCMClassMock([DataLayerHistoryWriter class]);
	self.dataLayerViewer = [[XZDataLayerViewer alloc] initWithStore:self.storeMock writer:self.dataLayerHistoryWriterMock dataLayerObserver:self.dataLayerObserverMock applicationDelegate:self.appDelegate];
	self.dataLayerViewerPartialMock = OCMPartialMock(self.dataLayerViewer);
}

- (void)tearDown {
	self.dataLayerViewer = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Singltone tests
- (void)testSharedInstanceShouldReturnNonNilObject {
	expect([XZDataLayerViewer sharedInstance]).toNot.beNil();
}

- (void)testInitShouldCreateUniqueInstance {
	expect([[XZDataLayerViewer alloc] init]).toNot.beNil();
}

- (void)testSharedInstanceShouldBeIdempotent {
	XZDataLayerViewer *s1 = [XZDataLayerViewer sharedInstance];
	expect(s1).equal([XZDataLayerViewer sharedInstance]);
}

- (void)testSharedInstanceShouldReturnSeparateObjectFromReturnedByInit {
	XZDataLayerViewer *s1 = [XZDataLayerViewer sharedInstance];
	expect(s1).notTo.equal([[XZDataLayerViewer alloc] init]);
}

- (void)testInitReturnsUniqueInstances {
	XZDataLayerViewer *s1 = [[XZDataLayerViewer alloc] init];
	expect(s1).notTo.equal([[XZDataLayerViewer alloc] init]);
}

#pragma mark - Tests
- (void)testInitShouldSaveInjectedValues{
	// given
	id<StoreProtocol> store = OCMClassMock([MemoryEventsHistoryStore class]);
	DataLayerObserver *observer = OCMClassMock([DataLayerObserver class]);
	DataLayerHistoryWriter *writer = OCMClassMock([DataLayerHistoryWriter class]);
	id<UIApplicationDelegate> appDelegate = OCMProtocolMock(@protocol(UIApplicationDelegate));
	
	// when
	XZDataLayerViewer *instance = [[XZDataLayerViewer alloc] initWithStore:store writer:writer dataLayerObserver:observer applicationDelegate:appDelegate];
	
	// then
	expect(instance).toNot.beNil();
	expect(instance.store).to.beIdenticalTo(store);
	expect(instance.observer).to.beIdenticalTo(observer);
	expect(instance.writer).to.beIdenticalTo(writer);
	expect(instance.appDelegate).to.beIdenticalTo(appDelegate);
}

- (void)testConfigureShouldCreateSharedInstanceAndSetupConfiguration{
	// given
	NSUInteger maxHistoryItems = rand();
	TAGDataLayer *tagDataLayerMock = OCMClassMock([TAGDataLayer class]);
	TAGManager *tagManagerMock = OCMClassMock([TAGManager class]);
	OCMStub(ClassMethod([(id)tagManagerMock instance])).andReturn(tagManagerMock);
	OCMStub([tagManagerMock dataLayer]).andReturn(tagDataLayerMock);
	id<UIApplicationDelegate> applicationDelegateMock = OCMProtocolMock(@protocol(UIApplicationDelegate));
	
	// when
	[XZDataLayerViewer configureWithTagManger:tagManagerMock applicationDelegate:applicationDelegateMock maxHistoryItems:maxHistoryItems];
	XZDataLayerViewer *instance = [XZDataLayerViewer sharedInstance];
	
	// then
	expect(instance.observer).toNot.beNil();
	expect(instance.observer.dataLayer).to.beIdenticalTo(tagDataLayerMock);
	expect(instance.writer).toNot.beNil();
	expect(instance.store).toNot.beNil();
	expect(instance.appDelegate).to.beIdenticalTo(applicationDelegateMock);
}

- (void)testViewControllerShouldReturnInitalizedInterface{
	// given
	// all setup
	
	// when
	UINavigationController *interface = (UINavigationController*)[self.dataLayerViewer viewerInterface];
	ViewController *historyViewer = (ViewController*)interface.topViewController;
	
	// then
	expect(interface).toNot.beNil();
	expect(interface).to.beAKindOf([UINavigationController class]);
	expect(interface.topViewController).toNot.beNil();
	expect(historyViewer).to.beAKindOf([ViewController class]);
	expect(historyViewer.dataSource).toNot.beNil();
	expect(historyViewer.dataSource).beAKindOf([HistoryDataSource class]);
	
}

#pragma mark - Helper methods

@end
