//
//  XZDataLayerViewer - XZDefaultStoreWriterTest.m
//  Copyright 2017 Andrey Ostanin. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZDefaultStoreWriter.h"

// Collaborators
#import "XZStoreProtocol.h"
#import "XZEventHistoryElement.h"

@interface XZDefaultStoreWriterTest : XCTestCase
@property(nonatomic,strong)XZDefaultStoreWriter *writer;
@property(nonatomic,strong)id<XZStoreProtocol> storeMock;
@end

@implementation XZDefaultStoreWriterTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.storeMock = OCMProtocolMock(@protocol(XZStoreProtocol));
	self.writer = [[XZDefaultStoreWriter alloc] initWithStore:self.storeMock];
}

- (void)tearDown {
	self.writer = nil;
	self.storeMock = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testClassShouldConfirmToXZStoreWriterProtocol{
	expect(self.writer).to.conformTo(@protocol(XZStoreWriterProtocol));
}

- (void)testInitShouldSaveInjectedObjectsInProperties{
	// when
	// everything setUp
	
	// then
	expect(self.writer.store == self.storeMock).to.beTruthy();
}

- (void)testWriteDataLayerShouldCallStoreAddObject{
	// given
	NSDictionary *dataLayerModel = @{};
	XZEventHistoryElement *eventHistoryMock = OCMClassMock([XZEventHistoryElement class]);
	OCMStub(ClassMethod([(id)eventHistoryMock alloc])).andReturn(eventHistoryMock);
	OCMStub([eventHistoryMock initWithData:OCMOCK_ANY]).andReturn(eventHistoryMock);
	
	// when
	[self.writer writeDataCopyToStore:dataLayerModel];
	
	// then
	OCMVerify([self.storeMock addObject:[OCMArg isEqual:eventHistoryMock]]);
}

- (void)testWriterShouldIgnoreNilDataLayerObject{
	// given
	NSDictionary *dataLayerModel = nil;
	OCMReject([self.storeMock addObject:OCMOCK_ANY]);
	
	// when
	[self.writer writeDataCopyToStore:dataLayerModel];
}

- (void)testWriterShouldNotCallStoreAddObjectIfEventHistoryWasntCreatedWithDataLayer{
	// given
	NSDictionary *dataLayerModel = @{};
	XZEventHistoryElement *eventHistoryMock = OCMClassMock([XZEventHistoryElement class]);
	OCMStub(ClassMethod([(id)eventHistoryMock alloc])).andReturn(nil);
	OCMReject([self.storeMock addObject:OCMOCK_ANY]);
	
	// when
	[self.writer writeDataCopyToStore:dataLayerModel];
	
	//then
	OCMVerifyAll((id)self.storeMock);
}

@end
