//
//  XZDataLayerViewer - TAGDataLayer_CustomPropertiesTest.m
//  Copyright 2017 Andrey Ostanin. All rights reserved.
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
- (void)testDataLayerModelDeepCopyShouldGetDataLayerModelWithKVC{
	// given
	NSDictionary *modelMock = OCMClassMock([NSDictionary class]);
	OCMStub([self.dataLayerMock valueForKey:@"model"]).andReturn(modelMock);
	OCMStub([self.dataLayerMock dataLayerModelDeepCopy]).andForwardToRealObject();

	// when
	NSDictionary *dataLayerModelDeepCopy = [self.dataLayerMock dataLayerModelDeepCopy];

	// then
	expect(dataLayerModelDeepCopy).notTo.beIdenticalTo(modelMock);
	OCMVerifyAll(self.dataLayerMock);
}

- (void)testDataLayerModelDeepCopyShouldReturnDeepCopyOfModelObject{
	// given
	NSDictionary *testModel = @{@"testKey":@"testValue"};
	OCMStub([self.dataLayerMock valueForKey:@"model"]).andReturn(testModel);
	OCMStub([self.dataLayerMock dataLayerModelDeepCopy]).andForwardToRealObject();
	
	// when
	NSDictionary *dataLayerModelDeepCopy = [self.dataLayerMock dataLayerModelDeepCopy];
	
	// then
	expect(dataLayerModelDeepCopy).to.equal(testModel);
	expect(dataLayerModelDeepCopy).notTo.beIdenticalTo(testModel);
}
@end
