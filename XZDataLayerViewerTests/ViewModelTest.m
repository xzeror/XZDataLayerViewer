//
//  XZDataLayerViewer - ViewModelTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZViewModel.h"

// Collaborators


@interface ViewModelTest : XCTestCase
@end


@implementation ViewModelTest

#pragma mark - Tests
- (void)testInitShouldSaveInjectedValues{
	// given
	NSString *testKey = @"testKey";
	NSString *testValue = @"testValue";
	BOOL testShouldShowDisclosureIndicator = YES;

	// when
	XZViewModel *viewModel = [[XZViewModel alloc] initWithKey:testKey value:testValue shouldShowDisclosureIndicator:testShouldShowDisclosureIndicator];

	// then
	expect(viewModel.key).to.equal(testKey);
	expect(viewModel.value).to.equal(testValue);
	expect(viewModel.shouldShowDisclosureIndicator).to.equal(testShouldShowDisclosureIndicator);
}

@end
