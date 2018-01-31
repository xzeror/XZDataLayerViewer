//
//  XZViewerTableViewCell.m
//  Tests
//
//  Created by Sergey Sayfulin (Ozon) on 28/12/2017.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "XZViewerTableViewCell.h"

@interface XZViewerTableViewCellTest : XCTestCase

@property (nonatomic, strong) XZViewerTableViewCell *cell;

@end

@implementation XZViewerTableViewCellTest

- (void)setUp {
    [super setUp];

    self.cell = [[XZViewerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

- (void)tearDown {
    self.cell = nil;
    
    [super tearDown];
}

#pragma mark - Tests

- (void)testSetTitle {
    // given
    NSString *testTitle = @"testTitle";
    
    // when
    self.cell.title = testTitle;
    
    //then
    expect(self.cell.textLabel.text).equal(testTitle);
}

- (void)testSetTitleToNil {
    // given
    NSString *testTitle = nil;
    
    // when
    self.cell.title = testTitle;
    
    //then
    expect(self.cell.textLabel.text).beNil();
}

- (void)testSetSubtitle {
    // given
    NSString *testSubtitle = @"testSubtitle";
    
    // when
    self.cell.subtitle = testSubtitle;
    
    //then
    expect(self.cell.detailTextLabel.text).equal(testSubtitle);
}

- (void)testSetSubtitleToNil {
    // given
    NSString *testSubtitle = nil;
    
    // when
    self.cell.subtitle = testSubtitle;
    
    //then
    expect(self.cell.detailTextLabel.text).beNil();
}

- (void)testGetTitle {
    // given
    NSString *testTitle = @"testTitle";
    self.cell.textLabel.text = testTitle;
    
    // when
    NSString *result = self.cell.title;
    
    // then
    expect(result).equal(testTitle);
}

- (void)testGetSubtitle {
    // given
    NSString *testSubtitle = @"testSubtitle";
    self.cell.detailTextLabel.text = testSubtitle;
    
    // when
    NSString *result = self.cell.subtitle;
    
    // then
    expect(result).equal(testSubtitle);
}

@end
