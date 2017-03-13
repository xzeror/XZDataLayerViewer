//
//  XZDataLayerViewer - ViewControllerTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZViewerInterface.h"

// Collaborators
#import "XZDataSourceFabric.h"
#import "XZDataSourceProtocol.h"
#import "XZViewModel.h"

// see comments in testDidSelectRowAtIndexPathShouldCreateAndPushDetailViewController
#import "XZDictionaryDataSource.h"

@interface XZViewerInterfaceTest : XCTestCase
@property(nonatomic,strong)XZViewerInterface *viewController;
@property(nonatomic,strong)XZViewerInterface *viewControllerPartialMock;
@property(nonatomic,strong)id<XZDataSourceProtocol> dataSourceMock;
@property(nonatomic,strong)NSIndexPath *validIndexPath;
@property(nonatomic,assign)NSUInteger validCount;
@property(nonatomic,strong)UINavigationController *navigationControllerMock;
@property(nonatomic,strong)XZDataSourceFabric *dataSourceFabricMock;
@property(nonatomic,strong)UITableView *tableViewMock;
@end


@implementation XZViewerInterfaceTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.validIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	self.validCount = self.validIndexPath.row + 1;
	
	self.dataSourceMock = OCMProtocolMock(@protocol(XZDataSourceProtocol));
	OCMStub([self.dataSourceMock count]).andReturn(self.validCount);
	
	self.dataSourceFabricMock = OCMClassMock([XZDataSourceFabric class]);
	
	self.navigationControllerMock = OCMClassMock([UINavigationController class]);
	
	self.tableViewMock = OCMClassMock([UITableView class]);
	
	self.viewController = [[XZViewerInterface alloc] initWithDataSource:self.dataSourceMock];
	self.viewControllerPartialMock = OCMPartialMock(self.viewController);
	OCMStub([self.viewControllerPartialMock navigationController]).andReturn(self.navigationControllerMock);
	OCMStub([self.viewControllerPartialMock tableView]).andReturn(self.tableViewMock);
}

- (void)tearDown {
	self.validIndexPath = nil;
	self.validCount = 0;
	
	self.dataSourceMock = OCMProtocolMock(@protocol(XZDataSourceProtocol));
	OCMStub([self.dataSourceMock count]).andReturn(self.validCount);
	
	self.dataSourceFabricMock = OCMClassMock([XZDataSourceFabric class]);
	
	self.navigationControllerMock = OCMClassMock([UINavigationController class]);
	
	self.viewControllerPartialMock = [[XZViewerInterface alloc] initWithDataSource:self.dataSourceMock];
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testInitShouldSaveDataSource{
	// given
	// view controller initialized

	// then
	expect(self.viewControllerPartialMock.dataSource == self.dataSourceMock).to.beTruthy();
}

- (void)testInitShouldSetupRightNavigationItem{
	expect(self.viewControllerPartialMock.navigationItem.rightBarButtonItem).toNot.beNil();
	expect(self.viewControllerPartialMock.navigationItem.rightBarButtonItem.target).to.equal(self.viewController);
	expect(self.viewControllerPartialMock.navigationItem.rightBarButtonItem.action).to.equal(@selector(refresh));
	
}

- (void)testNumberOfSectionsShouldReturnOne{
	expect([self.viewControllerPartialMock numberOfSectionsInTableView:self.viewControllerPartialMock.tableView]).equal(1);
}

- (void)testNumberOfRowsInSectionShouldReturnNumberOfRowsInDataSource{
	// given
	// all setup
	
	// when
	NSInteger realNumberOfRows = [self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView numberOfRowsInSection:0];
	
	// then
	expect(realNumberOfRows).equal(self.validCount);
	OCMVerify([self.dataSourceMock count]);
}

- (void)testCellForRowAtIndexPathShouldReturnNonNilCellWhenReusableCellsExistInTableView{
	// given
	id cellMock = OCMClassMock([UITableViewCell class]);
	OCMStub([self.tableViewMock dequeueReusableCellWithIdentifier:OCMOCK_ANY]).andReturn(cellMock);
	
	// when
	id cell = [self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView cellForRowAtIndexPath:self.validIndexPath];
	
	// then
	OCMVerify([self.tableViewMock dequeueReusableCellWithIdentifier:OCMOCK_ANY]);
	expect(cell).to.beIdenticalTo(cellMock);
}

- (void)testCellForRowAtIndexPathShouldReturnNonNilCellWhenNoReusableCellsInTableView{
	// given
	OCMStub([self.tableViewMock dequeueReusableCellWithIdentifier:OCMOCK_ANY]).andReturn(nil);
	
	// when
	UITableViewCell *cell = [self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView cellForRowAtIndexPath:self.validIndexPath];
	
	// then
	expect(cell).toNot.beNil();
}

- (void)testCellForRowAtIndexPathShouldConfigureCellForDisclosableViewModel{
	// given
	XZViewModel *viewModelMock = [self disclosableViewModel];
	[self dataSourceMockShouldReturn:viewModelMock];
	
	// when
	UITableViewCell *cell = [self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView cellForRowAtIndexPath:self.validIndexPath];
	
	// then
	expect(cell).toNot.beNil();
	expect(cell.textLabel.text).to.equal([viewModelMock key]);
	expect(cell.detailTextLabel.text).to.beNil();
	expect(cell.accessoryType).to.equal(UITableViewCellAccessoryDisclosureIndicator);
}

- (void)testCellForRowAtIndexPathShouldConfigureCellForLeafViewModel{
	// given
	XZViewModel *viewModelMock = [self leafViewModel];
	[self dataSourceMockShouldReturn:viewModelMock];
	
	// when
	UITableViewCell *cell = [self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView cellForRowAtIndexPath:self.validIndexPath];
	
	// then
	expect(cell).toNot.beNil();
	expect(cell.textLabel.text).to.equal([viewModelMock key]);
	expect(cell.detailTextLabel.text).to.equal([viewModelMock value]);
	expect(cell.accessoryType).to.equal(UITableViewCellAccessoryNone);
}

- (void)testCellForRowAtIndexPathShouldConfigureCellEmptyCellForNilViewModel{
	// given
	[self dataSourceMockShouldReturn:nil];
	
	// when
	UITableViewCell *cell = [self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView cellForRowAtIndexPath:self.validIndexPath];
	
	// then
	expect(cell).toNot.beNil();
	expect(cell.textLabel.text).to.equal(@"empty");
}

- (void)testDidSelectRowAtIndexPathShouldTakeRawDataFromStore{
	// given
	// all setup
	
	// when
	[self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView didSelectRowAtIndexPath:self.validIndexPath];
	
	// then
	OCMVerify([self.dataSourceMock rawDataForIndexPath:self.validIndexPath]);
}

- (void)testDidSelectRowAtIndexPathShouldCreateDataSourceForDetailViewController{
	// given
	id rawData = @{};
	OCMStub([self.dataSourceMock rawDataForIndexPath:self.validIndexPath]).andReturn(rawData);
	OCMStub(ClassMethod([(id)self.dataSourceFabricMock dataSourceForData:rawData]));
	
	// when
	[self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView didSelectRowAtIndexPath:self.validIndexPath];
	
	// then
	OCMVerify(ClassMethod([(id)self.dataSourceFabricMock dataSourceForData:rawData]));
}

- (void)testDidSelectRowAtIndexPathShouldCreateAndPushDetailViewController{
	// given
//	id dataSourceMock = OCMProtocolMock(@protocol(DataSourceProtocol));
//	!!!: Unfortunately we can't use protocol mock here because some how it crashes test
//	     I guess this is because OCMockObject is NSProxy descendant, and can't be retained
//		 properly in OCMVerify(... [OCMArt checkWithBlock:...]) or it can be due to errors in OCMock
//       So we will use any DataSourceProtocol compliant object
	id rawData = @{};
	[self dataSourceMockShouldReturn:rawData];
	id dataSourceMock = OCMClassMock([XZDictionaryDataSource class]);
	OCMStub(ClassMethod([(id)self.dataSourceFabricMock dataSourceForData:OCMOCK_ANY])).andReturn(dataSourceMock);
	OCMStub([self.navigationControllerMock pushViewController:OCMOCK_ANY animated:YES]);
	
	// when
	[self.viewControllerPartialMock tableView:self.tableViewMock didSelectRowAtIndexPath:self.validIndexPath];
	
	// then
	OCMVerify([self.navigationControllerMock pushViewController:[OCMArg checkWithBlock:^BOOL(id obj) {
		expect(obj).toNot.beNil();
		expect([obj dataSource]).to.beIdenticalTo(dataSourceMock);
		return YES;
	}] animated:YES]);
}

- (void)testDidSelectRowAtIndexPathShouldDoNothingForInvalidIndexPath{
	// given
	NSIndexPath *invalidIndexPath = [NSIndexPath indexPathForRow:self.validIndexPath.row + 1 inSection:self.validIndexPath.section];
	OCMReject([self.dataSourceMock rawDataForIndexPath:OCMOCK_ANY]);
	
	// when
	[self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView didSelectRowAtIndexPath:invalidIndexPath];
	
	// then
	OCMVerifyAll((id)self.dataSourceMock);
}

- (void)testDidSelectRowAtIndexPathShouldDoNothingForNilRawData{
	// given
	[self dataSourceMockShouldReturn:nil];
	
	OCMReject(ClassMethod([(id)self.dataSourceFabricMock dataSourceForData:OCMOCK_ANY]));
	OCMReject([self.navigationControllerMock pushViewController:OCMOCK_ANY animated:YES]);
	OCMReject([self.navigationControllerMock pushViewController:OCMOCK_ANY animated:NO]);
	
	// when
	[self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView didSelectRowAtIndexPath:self.validIndexPath];
	
	// then
	OCMVerifyAll((id)self.dataSourceFabricMock);
	OCMVerifyAll((id)self.navigationControllerMock);
}

- (void)testDidSelectRowAtIndexPathShouldDoNothingForNilDataSource{
	// given
	id rawData = @{};
	[self dataSourceMockShouldReturn:rawData];
	OCMStub(ClassMethod([(id)self.dataSourceFabricMock dataSourceForData:rawData])).andReturn(nil);
	
	OCMReject([self.navigationControllerMock pushViewController:OCMOCK_ANY animated:YES]);
	OCMReject([self.navigationControllerMock pushViewController:OCMOCK_ANY animated:NO]);
	
	// when
	[self.viewControllerPartialMock tableView:self.viewControllerPartialMock.tableView didSelectRowAtIndexPath:self.validIndexPath];
	
	// then
	OCMVerifyAll((id)self.navigationControllerMock);
}

- (void)testRefreshShouldCallTableViewReloadData{
	// given
	// all setup
	
	// when
	[self.viewControllerPartialMock refresh];
	
	// then
	OCMVerify([self.tableViewMock reloadData]);
}

#pragma mark - Helpers
- (XZViewModel*)disclosableViewModel{
	NSString *key = @"testKey";
	id value = @{};
	BOOL shouldShowDisclosureIndicator = YES;
	XZViewModel *viewModelMock = OCMClassMock([XZViewModel class]);
	OCMStub([viewModelMock key]).andReturn(key);
	OCMStub([viewModelMock value]).andReturn(value);
	OCMStub([viewModelMock shouldShowDisclosureIndicator]).andReturn(shouldShowDisclosureIndicator);
	return viewModelMock;
}

- (XZViewModel*)leafViewModel{
	NSString *key = @"testKey";
	id value = @"testValue";
	BOOL shouldShowDisclosureIndicator = NO;
	XZViewModel *viewModelMock = OCMClassMock([XZViewModel class]);
	OCMStub([viewModelMock key]).andReturn(key);
	OCMStub([viewModelMock value]).andReturn(value);
	OCMStub([viewModelMock shouldShowDisclosureIndicator]).andReturn(shouldShowDisclosureIndicator);
	return viewModelMock;
}

- (void)dataSourceMockShouldReturn:(id)object{
	OCMStub([self.dataSourceMock viewModelForIndexPath:self.validIndexPath]).andReturn(object);
	OCMStub([self.dataSourceMock rawDataForIndexPath:self.validIndexPath]).andReturn(object);
}

@end
