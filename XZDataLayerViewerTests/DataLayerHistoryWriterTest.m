//
//  XZDataLayerViewer - DataLayerHistoryWriterTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "DataLayerHistoryWriter.h"

// Collaborators
#import <UIKit/UIKit.h>
#import "StoreProtocol.h"

@interface DataLayerHistoryWriterTest : XCTestCase
@property(nonatomic,strong)DataLayerHistoryWriter *dataLayerHistoryWriter;
@property (nonatomic, strong)id<StoreProtocol> storeMock;
@property (nonatomic, strong) NSNotificationCenter *notificationCenterMock;
@end


@implementation DataLayerHistoryWriterTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.storeMock = OCMProtocolMock(@protocol(StoreProtocol));
	self.notificationCenterMock = OCMClassMock([NSNotificationCenter class]);
	self.dataLayerHistoryWriter = [[DataLayerHistoryWriter alloc] initWithStore:self.storeMock notificationCenter:self.notificationCenterMock];
}

- (void)tearDown {
	self.dataLayerHistoryWriter = nil;
	self.storeMock = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testInitWithStoreSavesStorePointerInside{
	// given
	// objects were initialized in setUp

	// then
//	expect(self.dataLayerHistoryWriter valueForKey:[@""]);
}

@end
