//
//  XZDataLayerViewer - UIApplication+TopmostViewController.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "UIWindow+TopmostViewController.h"

// Collaborators


@interface UIWindow_TopmostViewController : XCTestCase
@end


@implementation UIWindow_TopmostViewController

- (void)setUp {
	[super setUp]; // must be the first line in method
}

- (void)tearDown {
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testCurrentViewControllerShouldReturnRootViewControllerForSimpleViewControllerHierarchy{
	// given
	UIViewController *rootViewControllerMock = OCMClassMock([UIViewController class]);
	OCMStub([rootViewControllerMock presentedViewController]).andReturn(nil);
	
	UIWindow *windowMock = OCMClassMock([UIWindow class]);
	OCMStub([windowMock rootViewController]).andReturn(rootViewControllerMock);

	// when
	UIViewController *foundViewController = [UIWindow topmostViewControllerOfWindow:windowMock];

	// then
	expect(foundViewController).toNot.beNil();
	expect(foundViewController).to.beIdenticalTo(rootViewControllerMock);
}

- (void)testCurrentViewControllerShouldReturnViewController{
	// given
	UIViewController *presentedViewController = OCMClassMock([UIViewController class]);
	UIViewController *rootViewControllerMock = OCMClassMock([UIViewController class]);
	OCMStub([rootViewControllerMock presentedViewController]).andReturn(presentedViewController);
	
	UIWindow *windowMock = OCMClassMock([UIWindow class]);
	OCMStub([windowMock rootViewController]).andReturn(rootViewControllerMock);
	
	// when
	UIViewController *foundViewController = [UIWindow topmostViewControllerOfWindow:windowMock];
	
	// then
	expect(foundViewController).toNot.beNil();
	expect(foundViewController).to.beIdenticalTo(presentedViewController);
}

@end
