//
//  XZDataLayerViewer - TAGDataLayer_CustomPropertiesTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "TAGDataLayer+CustomProperties.h"

// Collaborators
#import "TAGDataLayer.h"
//#import "TAGManager.h"


@interface TAGDataLayer_CustomPropertiesTest : XCTestCase
@property(nonatomic,strong)TAGDataLayer *dataLayer;
@property(nonatomic,strong)id dataLayerMock;
@end


@implementation TAGDataLayer_CustomPropertiesTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.dataLayer = [[TAGDataLayer alloc] init];
	self.dataLayerMock = OCMPartialMock(self.dataLayer);
}

- (void)tearDown {
	self.dataLayerMock = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testShouldGetDataLayerModelWithKVC{
	// given
	NSDictionary *modelMock = OCMClassMock([NSDictionary class]);
	OCMStub([self.dataLayerMock valueForKey:@"model"]).andReturn(modelMock);
	OCMStub([self.dataLayerMock dataLayerModel]).andForwardToRealObject();

	// when
	NSDictionary *dataLayerModel = [self.dataLayerMock dataLayerModel];

	// then
	expect(dataLayerModel).to.beIdenticalTo(modelMock);
	OCMVerifyAll(self.dataLayerMock);
}
@end
