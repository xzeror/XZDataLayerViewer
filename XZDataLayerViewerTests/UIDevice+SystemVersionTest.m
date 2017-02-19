//
//  XZDataLayerViewer - UIDevice_SystemVersionTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "UIDevice+SystemVersion.h"

// Collaborators


@interface UIDevice_SystemVersionTest : XCTestCase
@property (nonatomic, strong)UIDevice *uideviceMock;
@end


@implementation UIDevice_SystemVersionTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.uideviceMock = OCMPartialMock([UIDevice currentDevice]);
	OCMStub([(id)self.uideviceMock currentDevice]).andReturn(self.uideviceMock);
}

- (void)tearDown {
	self.uideviceMock = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testSystemVersionLessThanReturnsTrueWhenRealSystemVersionLessThanTestedValue{
	// given
	NSString *testedSystemVersionValue = @"2.0";
	NSString *simulatedSystemVersionValue = @"1.0";
	OCMStub([self.uideviceMock systemVersion]).andReturn(simulatedSystemVersionValue);

	// when
	BOOL result = [self.uideviceMock isSystemVersionLessThan:testedSystemVersionValue];

	// then
	expect(result).to.beTruthy();
}

- (void)testSystemVersionLessThanReturnsFalseWhenRealSystemVersionGreaterThanTestedValue{
	// given
	NSString *testedSystemVersionValue = @"2.0";
	NSString *simulatedSystemVersionValue = @"3.0";
	OCMStub([self.uideviceMock systemVersion]).andReturn(simulatedSystemVersionValue);
	
	// when
	BOOL result = [self.uideviceMock isSystemVersionLessThan:testedSystemVersionValue];
	
	// then
	expect(result).to.beFalsy();
}

@end
