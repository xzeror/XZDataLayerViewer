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

@interface DataLayerHistoryWriterTest : XCTestCase
@property(nonatomic,strong)DataLayerHistoryWriter *<#classUnderTestInstanceName#>
@end


@implementation DataLayerHistoryWriterTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.<#classUnderTestInstanceName#> = [[DataLayerHistoryWriter alloc] init];
}

- (void)tearDown {
	self.<#classUnderTestInstanceName#> = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)test<#Test Name#>{
	// given

	// when

	// then
    expect(@"Unit tests are not implemented yet in DataLayerHistoryWriterTest").beNil();
}

@end
