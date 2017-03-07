//
//  XZDataLayerViewer.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "XZDataLayerViewer.h"
#import "XZDataLayerViewer+Extension.h"
#import "DataLayerObserver.h"
#import "DataLayerHistoryWriter.h"
#import "MemoryEventsHistoryStore.h"
#import "TAGManager.h"
#import "DataSourceProtocol.h"
#import "HistoryDataSource.h"
#import "ViewController.h"

static XZDataLayerViewer *sharedInstance = nil;

@implementation XZDataLayerViewer
+ (instancetype)sharedInstance{
	NSAssert(sharedInstance, @"XZDataLayerViewer hasn't been configured yet. Please calll '+configureWithTagManger:applicationDelegate:maxHistoryItems:' first.");
	return sharedInstance;
}

+ (void)configureWithTagManger:(TAGManager*)tagManager applicationDelegate:(id<UIApplicationDelegate>)appDelegate maxHistoryItems:(NSUInteger)maxHistoryItems{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		TAGDataLayer *dataLayer = [TAGManager instance].dataLayer;
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		id<StoreProtocol> store = [[MemoryEventsHistoryStore alloc] initWithHistoryLimit:maxHistoryItems];
		DataLayerObserver *observer = [[DataLayerObserver alloc] initWithDataLayer:dataLayer];
		DataLayerHistoryWriter *writer = [[DataLayerHistoryWriter alloc] initWithStore:store notificationCenter:notificationCenter];
		sharedInstance = [[XZDataLayerViewer alloc] initWithStore:store writer:writer dataLayerObserver:observer applicationDelegate:appDelegate];
	});
}

- (instancetype)initWithStore:(id<StoreProtocol>)store
					   writer:(DataLayerHistoryWriter*)writer
			dataLayerObserver:(DataLayerObserver*)observer
		  applicationDelegate:(id<UIApplicationDelegate>)appDelegate;{
	self = [super init];
	if (self) {
		_store = store;
		_writer = writer;
		_observer = observer;
		_appDelegate = appDelegate;
	}
	return self;
}

- (UIViewController*)viewerInterface{
	id<DataSourceProtocol> historyDataSource = [[HistoryDataSource alloc] initWithStore:self.store];
	ViewController *historyViewController = [[ViewController alloc] initWithDataSource:historyDataSource];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
	return navigationController;
}

@end
