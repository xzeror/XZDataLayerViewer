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
#import "XZViewerInterface.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"
#import "XZStoreProtocol.h"
#import "XZStoreWriterProtocol.h"
#import "XZEventGeneratorProtocol.h"
#import "XZHistoryDataSource.h"
#import "XZDataLayerObserver.h"
#import "XZDefaultStoreWriter.h"
#import "XZMemoryEventsHistoryStore.h"

@interface XZDataLayerViewerTest : XCTestCase
@property(nonatomic,strong)XZDataLayerViewer *dataLayerViewer;
@property(nonatomic,strong)XZDataLayerViewer *dataLayerViewerPartialMock;
@property(nonatomic,strong)id<XZStoreProtocol> storeMock;
@property(nonatomic,strong)id<XZEventGeneratorProtocol> eventGeneratorMock;
@property(nonatomic,strong)id<XZStoreWriterProtocol> storeWriterMock;
@property(nonatomic,strong)id<UIApplicationDelegate> appDelegate;
@end


@implementation XZDataLayerViewerTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.storeMock = OCMProtocolMock(@protocol(XZStoreProtocol));
	self.eventGeneratorMock = OCMProtocolMock(@protocol(XZEventGeneratorProtocol));
	self.storeWriterMock = OCMProtocolMock(@protocol(XZStoreWriterProtocol));
	self.dataLayerViewer = [[XZDataLayerViewer alloc] initWithStore:self.storeMock writer:self.storeWriterMock dataLayerObserver:self.eventGeneratorMock];
	self.dataLayerViewerPartialMock = OCMPartialMock(self.dataLayerViewer);
}

- (void)tearDown {
	self.dataLayerViewer = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Tests
- (void)testInitShouldSaveInjectedValues{
	// given
	id<XZStoreProtocol> store = OCMClassMock([XZMemoryEventsHistoryStore class]);
	id<XZEventGeneratorProtocol> eventGenerator= OCMClassMock([XZDataLayerObserver class]);
	id<XZStoreWriterProtocol> writer = OCMClassMock([XZDefaultStoreWriter class]);
	
	// when
	XZDataLayerViewer *instance = [[XZDataLayerViewer alloc] initWithStore:store writer:writer dataLayerObserver:eventGenerator];
	
	// then
	expect(instance).toNot.beNil();
	expect(instance.store).to.beIdenticalTo(store);
	expect(instance.eventGenerator).to.beIdenticalTo(eventGenerator);
	expect(instance.writer).to.beIdenticalTo(writer);
}

- (void)testViewControllerShouldReturnInitalizedInterface{
	// given
	// all setup
	
	// when
	UINavigationController *interface = (UINavigationController*)[self.dataLayerViewer viewerInterface];
	XZViewerInterface *historyViewer = (XZViewerInterface*)interface.topViewController;
	
	// then
	expect(interface).toNot.beNil();
	expect(interface).to.beAKindOf([UINavigationController class]);
	expect(interface.topViewController).toNot.beNil();
	expect(historyViewer).to.beAKindOf([XZViewerInterface class]);
	expect(historyViewer.dataSource).toNot.beNil();
	expect(historyViewer.dataSource).beAKindOf([XZHistoryDataSource class]);
	
}

- (void)testObserverBlockShouldCallWriterMethod{
	// given
	NSDictionary *testData = @{};
	
	// when
	self.dataLayerViewer.observerBlock(testData);
	
	// then
	OCMVerify([self.storeWriterMock writeDataCopyToStore:testData]);
}

@end



@interface XZDataLayerViewerSingltoneTest : XCTestCase
@property(atomic,assign)BOOL configured;
@property(nonatomic,assign)NSUInteger maxHistoryItems;
@end

@implementation XZDataLayerViewerSingltoneTest

- (void)setUp{
	[super setUp];
	@synchronized (self) {
		if (self.configured == NO) {
			self.maxHistoryItems = 1000;
			TAGDataLayer *tagDataLayerMock = OCMClassMock([TAGDataLayer class]);
			TAGManager *tagManagerMock = OCMClassMock([TAGManager class]);
			OCMStub(ClassMethod([(id)tagManagerMock instance])).andReturn(tagManagerMock);
			OCMStub([tagManagerMock dataLayer]).andReturn(tagDataLayerMock);
			[XZDataLayerViewer configureWithTagManger:tagManagerMock store:[XZMemoryEventsHistoryStore class] eventGenerator:[XZDefaultObserver class] maxHistoryItems:self.maxHistoryItems];
			self.configured = YES;
		}
	}
}

#pragma mark - Singltone tests
- (void)testConfigureShouldCreateSharedInstanceAndSetupConfiguration{
	// given
	// all setup
	
	// when
	XZDataLayerViewer *instance = [XZDataLayerViewer sharedInstance];
	
	// then
	expect(instance.eventGenerator).toNot.beNil();
	expect(instance.eventGenerator.observers.count).to.beGreaterThan(0);
	expect(instance.writer).toNot.beNil();
	expect(instance.store).toNot.beNil();
	expect(instance.store.historyLimit).to.equal(self.maxHistoryItems);
}

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
@end

