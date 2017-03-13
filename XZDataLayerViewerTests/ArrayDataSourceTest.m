//
//  XZDataLayerViewer - ArrayDataSourceTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZArrayDataSource.h"

// Collaborators
#import "XZViewModel.h"


@interface ArrayDataSourceTest : XCTestCase
@property(nonatomic,strong)XZArrayDataSource *dataSource;
@property(nonatomic,strong)id dataMock;
@end


@implementation ArrayDataSourceTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.dataMock = OCMClassMock([NSArray class]);
	self.dataSource = [[XZArrayDataSource alloc] initWithArray:self.dataMock];
}

- (void)tearDown {
	self.dataMock = nil;
	self.dataSource = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Tests
- (void)testDataSourceShouldConformToDataSourceProtocol{
	// given
	// data source setup

	// then
	expect(self.dataSource).to.conformTo(@protocol(XZDataSourceProtocol));
}

- (void)testDataSourceShouldReturnCountOfDataElements{
	// given
	NSUInteger testCount = rand();
	OCMStub([self.dataMock count]).andReturn(testCount);

	// then
	expect(self.dataSource.count).to.equal(testCount);
}

- (void)testDataSourceShouldReturnNilViewModelForInvalidIndexPath{
	// given
	id testValue = @1;
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	NSIndexPath *invalidIndexPath = [NSIndexPath indexPathForRow:validIndexPath.row + 1 inSection:validIndexPath.section];
	
	// when
	XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:invalidIndexPath];
	
	// then
	expect(viewModel).to.beNil();
}

- (void)testDataSourceShouldReturnViewModelForValidIndexPath{
	// given
	id testValue = @"test";
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	
	// when
	XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:validIndexPath];
	
	// then
	expect(viewModel).toNot.beNil();
	expect(viewModel.key).to.equal(@(validIndexPath.row).stringValue);
	expect(viewModel.value).to.equal(testValue);
	expect(viewModel.shouldShowDisclosureIndicator).to.beFalsy();
}

- (void)testDataSourceShouldReturnViewModelWithDisclosureIndicatorForArrayValue{
	// given
	id testValue = @[];
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	
	// when
	XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:validIndexPath];
	
	// then
	expect(viewModel).toNot.beNil();
	expect(viewModel.key).to.equal(@(validIndexPath.row).stringValue);
	expect(viewModel.value).to.beNil();
	expect(viewModel.shouldShowDisclosureIndicator).to.beTruthy();
}

- (void)testDataSourceShouldReturnViewModelWithDisclosureIndicatorForDictionaryValue{
	// given
	id testValue = @{};
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	
	// when
	XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:validIndexPath];
	
	// then
	expect(viewModel).toNot.beNil();
	expect(viewModel.key).to.equal(@(validIndexPath.row).stringValue);
	expect(viewModel.value).to.beNil();
	expect(viewModel.shouldShowDisclosureIndicator).to.beTruthy();
}

- (void)testDataSourceShouldReturnNilRawValueForInvalidIndexPath{
	// given
	id testValue = @1;
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	NSIndexPath *invalidIndexPath = [NSIndexPath indexPathForRow:validIndexPath.row + 1 inSection:validIndexPath.section];
	
	// when
	id rawValue = [self.dataSource rawDataForIndexPath:invalidIndexPath];
	
	// then
	expect(rawValue).to.beNil();
}

- (void)testDataSourceShouldReturnRawValueForValidIndexPath{
	// given
	id testValue = @1;
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	
	// when
	id rawValue = [self.dataSource rawDataForIndexPath:validIndexPath];
	
	// then
	expect(rawValue).to.beIdenticalTo(testValue);
}

#pragma mark - Helpers
- (NSIndexPath*)setupDataMockToReturnValueAtIndexPath:(id)value{
	NSIndexPath *validIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
	NSUInteger testCount = validIndexPath.row + 1;
	
	OCMStub([self.dataMock objectAtIndex:validIndexPath.row]).andReturn(value);
	OCMStub([self.dataMock count]).andReturn(testCount);
	return validIndexPath;
}

@end
