//
//  XZDataLayerViewer.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "XZDataLayerViewer.h"
#import "XZDataLayerViewer+Extension.h"
#import "XZDataLayerObserver.h"
#import "XZDefaultStoreWriter.h"
#import "XZMemoryEventsHistoryStore.h"
#import "TAGManager.h"
#import "XZDataSourceProtocol.h"
#import "XZHistoryDataSource.h"
#import "XZViewerInterface.h"

static XZDataLayerViewer *sharedInstance = nil;

@implementation XZDataLayerViewer
+ (instancetype)sharedInstance{
	NSAssert(sharedInstance, @"XZDataLayerViewer hasn't been configured yet. Please calll '+configureWithTagManger:applicationDelegate:maxHistoryItems:' first.");
	return sharedInstance;
}

+ (void)configureWithTagManger:(TAGManager*)tagManager maxHistoryItems:(NSUInteger)maxHistoryItems{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		TAGDataLayer *dataLayer = [TAGManager instance].dataLayer;
		id<XZStoreProtocol> store = [[XZMemoryEventsHistoryStore alloc] initWithHistoryLimit:maxHistoryItems];
		id<XZEventGeneratorProtocol> observer = [[XZDataLayerObserver alloc] initWithDataLayer:dataLayer];
		id<XZStoreWriterProtocol> writer = [[XZDefaultStoreWriter alloc] initWithStore:store];
		[observer addObserver:^(id<NSObject,NSCoding,NSCopying> eventData) {
			[writer writeDataCopyToStore:eventData];
		}];
		sharedInstance = [[XZDataLayerViewer alloc] initWithStore:store writer:writer dataLayerObserver:observer];
	});
}

- (instancetype)initWithStore:(id<XZStoreProtocol>)store
					   writer:(id<XZStoreWriterProtocol>)writer
			dataLayerObserver:(id<XZEventGeneratorProtocol>)eventGenerator{
	self = [super init];
	if (self) {
		_store = store;
		_writer = writer;
		_eventGenerator = eventGenerator;
	}
	return self;
}

- (UIViewController*)viewerInterface{
	id<XZDataSourceProtocol> historyDataSource = [[XZHistoryDataSource alloc] initWithStore:self.store];
	XZViewerInterface *historyViewController = [[XZViewerInterface alloc] initWithDataSource:historyDataSource];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
	return navigationController;
}

@end
