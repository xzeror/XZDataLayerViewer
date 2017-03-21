//
//  XZDataLayerViewer - XZEventHistoryElementTest.m
//  Copyright 2017 Andrey Ostanin. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZEventHistoryElement.h"

// Collaborators


@interface XZEventHistoryElementTest : XCTestCase
@end


@implementation XZEventHistoryElementTest

- (void)setUp {
	[super setUp]; // must be the first line in method
}

- (void)tearDown {
//	self.element = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testElementInitCreatesDataDeepCopy{
	// given
	NSDictionary *data = @{@"test":@"test"};
	
	// when
	XZEventHistoryElement *element = [[XZEventHistoryElement alloc] initWithData:data];
	
	// then
	expect(element.data).to.equal(data);
	expect(element.data == data).to.beFalsy();
}

- (void)testElementInitSetsTimestampToCurrentDate{
	// given
	NSDictionary *dataLayer = @{@"test":@"test"};
	NSDate *date = OCMClassMock([NSDate class]);
	
	id nsdateMock = OCMClassMock([NSDate class]);
	OCMStub([nsdateMock date]).andReturn(date);
	
	// when
	XZEventHistoryElement *element = [[XZEventHistoryElement alloc] initWithData:dataLayer];
	
	// then
	expect(element.timestamp).notTo.beNil();
	expect(element.timestamp).equal(date);
	OCMVerify([nsdateMock date]);
}

- (void)testElementShouldNotBeCreatedIfDataDoesNotSupportNSCodingOrNSCopingProtocols{
	// given
	id data = OCMProtocolMock(@protocol(NSObject));
	
	// when
	XZEventHistoryElement *element = [[XZEventHistoryElement alloc] initWithData:data];
	
	// then
	expect(element).to.beNil();
}

@end
