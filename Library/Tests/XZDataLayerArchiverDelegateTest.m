//  Created by: Andrey Ostanin
//  Copyright 2017 XZone Software. All rights reserved.

// Class under test
#import "XZDataLayerArchiverDelegate.h"

// Collaborators
#import "TAGDataLayer.h"

@interface XZDataLayerArchiverDelegateTest : XCTestCase
@property(nonatomic,strong)XZDataLayerArchiverDelegate *delegate;
@end


@implementation XZDataLayerArchiverDelegateTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.delegate = [[XZDataLayerArchiverDelegate alloc] init];
}

- (void)tearDown {
	self.delegate = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testWillEncodeObjectReturnsStringWhenObjectIskDataLayerObjectNotPresent{
	// given
	id object = kTAGDataLayerObjectNotPresent;
	id archiever = [[NSCoder alloc] init];

	// when
	id result = [self.delegate archiver:archiever willEncodeObject:object];

	// then
	expect(result).to.beKindOf([NSString class]);
}

- (void)testWillEncodeObjectReturnsObjectWhenObjectIsNotkDataLayerObjectNotPresent{
	// given
	id object = [[NSObject alloc] init];
	id archiever = [[NSCoder alloc] init];

	// when
	id result = [self.delegate archiver:archiever willEncodeObject:object];

	// then
	expect(result).to.beIdenticalTo(object);
}



@end
