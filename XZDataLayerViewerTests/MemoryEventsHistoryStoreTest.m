//
//  XZDataLayerViewer - MemoryEventsHistoryStoreTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZMemoryEventsHistoryStore.h"

// Collaborators


@interface MemoryEventsHistoryStoreTest : XCTestCase
@property(nonatomic,strong)XZMemoryEventsHistoryStore *memoryStore;
@end


@implementation MemoryEventsHistoryStoreTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.memoryStore = [[XZMemoryEventsHistoryStore alloc] init];
}

- (void)tearDown {
	self.memoryStore = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testInitStoresHistoryLimit{
	// given
	NSUInteger historyLimit = 1;

	// when
	XZMemoryEventsHistoryStore *memoryStore = [[XZMemoryEventsHistoryStore alloc] initWithHistoryLimit:historyLimit];

	// then
	expect(memoryStore.historyLimit).equal(historyLimit);
}

- (void)testSetLowerHistoryLimitShouldTrimStore{
	// given
	NSUInteger oldLimit = self.memoryStore.historyLimit;
	NSUInteger newLimit = oldLimit / 2;
	[self fillMemoryStoreWithObjectsCount:oldLimit];
	NSArray *testData = [[self.memoryStore.objects subarrayWithRange:NSMakeRange(oldLimit - newLimit, newLimit)] mutableCopy];
	
	// when
	self.memoryStore.historyLimit = newLimit;
	
	// then
	expect(self.memoryStore.historyLimit).equal(newLimit);
	expect(self.memoryStore.objectsCount).equal(newLimit);
	expect(self.memoryStore.objects).haveCount(newLimit);
	expect(self.memoryStore.objects).equal(testData);
}

- (void)testSetHigherHistoryLimitShouldOnlyIncreasesHistoryLimit{
	// given
	NSUInteger oldLimit = self.memoryStore.historyLimit;
	NSUInteger newLimit = oldLimit * 2;
	[self fillMemoryStoreWithObjectsCount:oldLimit];
	NSArray *testData = [NSArray arrayWithArray:self.memoryStore.objects];
	
	// when
	self.memoryStore.historyLimit = newLimit;
	
	// then
	expect(self.memoryStore.historyLimit).equal(newLimit);
	expect(self.memoryStore.objectsCount).equal(oldLimit);
	expect(self.memoryStore.objects).haveCount(oldLimit);
	expect(self.memoryStore.objects).equal(testData);
}

- (void)testSetSameHistoryLimitShouldDoNothing{
	// given
	NSUInteger oldLimit = self.memoryStore.historyLimit;
	NSUInteger newLimit = oldLimit;
	[self fillMemoryStoreWithObjectsCount:oldLimit];
	NSArray *testData = [NSArray arrayWithArray:self.memoryStore.objects];
	
	// when
	self.memoryStore.historyLimit = newLimit;
	
	// then
	expect(self.memoryStore.historyLimit).equal(oldLimit);
	expect(self.memoryStore.objectsCount).equal(oldLimit);
	expect(self.memoryStore.objects).haveCount(oldLimit);
	expect(self.memoryStore.objects).equal(testData);
}

- (void)testAddObjectShouldAddObjectToStore{
	// given
	id testObject = [NSObject new];
	NSUInteger initialObjectsCount = self.memoryStore.objectsCount;
	NSUInteger finalObjectsCount = initialObjectsCount + 1;
	
	// when
	[self.memoryStore addObject:testObject];
	
	// then
	expect(self.memoryStore.objectsCount).equal(finalObjectsCount);
	expect(self.memoryStore.objects).contain(testObject);
}

- (void)testAddObjectShouldRemoveOldestItemOverHistoryLimit{
	// given
	NSUInteger finalObjectsCount = self.memoryStore.historyLimit;
	[self fillMemoryStoreWithObjectsCount:self.memoryStore.historyLimit];
	id firstObject = [self.memoryStore.objects firstObject];
	id lastObject = @(self.memoryStore.historyLimit);
	
	// when
	[self.memoryStore addObject:lastObject];
	
	// then
	expect(self.memoryStore.objectsCount).to.equal(finalObjectsCount);
	expect(self.memoryStore.objects).to.contain(lastObject);
	expect(self.memoryStore.objects).toNot.contain(firstObject);
	
}

- (void)testAddObjectShouldReturnObjectId{
	// given
	id testObject = [NSObject new];
	id objectStoreId = nil;
	
	// when
	objectStoreId = [self.memoryStore addObject:testObject];
	
	// then
	expect(objectStoreId).toNot.beNil();
}

- (void)testObjectWithIdShouldReturnObjectForValidStoreId{
	// given
	id testObject = [NSObject new];
	id objectStoreId = [self.memoryStore addObject:testObject];
	
	// when
	id readObject = [self.memoryStore objectWithId:objectStoreId];
	
	// then
	expect(readObject).toNot.beNil();
	expect(readObject).to.equal(testObject);
}

- (void)testObjectWithIdShouldReturnNilWithUnknownStoreId{
	// given
	[self fillMemoryStoreWithObjectsCount:1];
	id objectStoreId = [NSObject new];
	
	// when
	id readObject = [self.memoryStore objectWithId:objectStoreId];
	
	// then
	expect(readObject).to.beNil();
}

- (void)testObjectWithIdShouldReturnNilWithObjectIdBeyondObjectsCount{
	// given
	[self fillMemoryStoreWithObjectsCount:1];
	id testObjectId = @(self.memoryStore.objectsCount + 1);
	
	// when
	id readObject = [self.memoryStore objectWithId:testObjectId];
	
	// then
	expect(readObject).to.beNil();
}

- (void)testObjectsCountShouldReturnZeroForEmptyStore{
	// given
	// memory store setup
	
	// then
	expect(self.memoryStore.objectsCount).to.equal(0);
}

- (void)testObjectsCountShouldReturnCorrectNumberOfItemsForFilledStore{
	// given
	NSUInteger testCount = arc4random_uniform(self.memoryStore.historyLimit);
	
	// when
	[self fillMemoryStoreWithObjectsCount:testCount];
	
	// then
	expect(self.memoryStore.objectsCount).to.equal(testCount);
}

- (void)testObjectsCountShouldNeverReturnValueGreaterThanHistoryLimit{
	// given
	NSUInteger testCount = 2 * self.memoryStore.historyLimit;
	
	// when
	[self fillMemoryStoreWithObjectsCount:testCount];
	
	// then
	expect(self.memoryStore.objectsCount).to.equal(self.memoryStore.historyLimit);
}

- (void)testObjectsShouldNotReturnNilForEmptyStore{
	// given
	// memory store setup
	expect(self.memoryStore.objectsCount).equal(0);
	
	// then
	expect(self.memoryStore.objects).toNot.beNil();
}

- (void)testObjectsShouldNotReturnNilForFilledStore{
	// given
	// memory store setup
	NSUInteger testCount = self.memoryStore.historyLimit;
	[self fillMemoryStoreWithObjectsCount:testCount];
	expect(self.memoryStore.objectsCount).equal(testCount);
	
	// then
	expect(self.memoryStore.objects).toNot.beNil();
}

- (void)testObjectsShouldReturnNSArray{
	// given
	// memory store setup
	
	// then
	expect(self.memoryStore.objects).beAKindOf([NSArray class]);
	expect(self.memoryStore.objects).toNot.beAKindOf([NSMutableArray class]);
}

#pragma mark - Helpers
- (void)fillMemoryStoreWithObjectsCount:(NSUInteger)objectsCount{
	for (NSUInteger i = 0; i < objectsCount; i++) {
		[self.memoryStore addObject:@(i)];
	}
}
@end
