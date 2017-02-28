//
//  XZDataLayerViewer - EventHistoryElementTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "EventHistoryElement.h"

// Collaborators


@interface EventHistoryElementTest : XCTestCase
@end


@implementation EventHistoryElementTest

- (void)setUp {
	[super setUp]; // must be the first line in method
}

- (void)tearDown {
//	self.element = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testElementInitCreatesDataLayerDeepCopy{
	// given
	NSDictionary *dataLayer = @{@"test":@"test"};
	
	// when
	EventHistoryElement *element = [[EventHistoryElement alloc] initWithDataLayerModel:dataLayer];
	
	// then
	expect(element.dataLayerModel).to.equal(dataLayer);
	expect(element.dataLayerModel == dataLayer).to.beFalsy();
}

- (void)testElementInitSetsTimestampToCurrentDate{
	// given
	NSDictionary *dataLayer = @{@"test":@"test"};
	NSDate *date = OCMClassMock([NSDate class]);
	
	id nsdateMock = OCMClassMock([NSDate class]);
	OCMStub([nsdateMock date]).andReturn(date);
	
	// when
	EventHistoryElement *element = [[EventHistoryElement alloc] initWithDataLayerModel:dataLayer];
	
	// then
	expect(element.timestamp).notTo.beNil();
	expect(element.timestamp).equal(date);
	OCMVerify([nsdateMock date]);
}

@end
