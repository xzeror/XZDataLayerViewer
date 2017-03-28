//  Created by Andrey Ostanin on 06.03.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZDataLayerViewer+Public.h"
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

+ (void)configureWithTagManger:(TAGManager*)tagManager store:(Class)storeClass eventGenerator:(Class)eventGeneratorClass maxHistoryItems:(NSUInteger)maxHistoryItems{
	NSAssert([storeClass isKindOfClass:[NSObject class]], @"Store should be descendant of NSObject");
	NSAssert([storeClass conformsToProtocol:@protocol(XZStoreProtocol)], @"Store should conform to XZStoreProtocol");
	NSAssert([eventGeneratorClass isKindOfClass:[NSObject class]], @"Event generator should be descendant of NSObject");
	NSAssert([eventGeneratorClass conformsToProtocol:@protocol(XZEventGeneratorProtocol)], @"Event generator should conform to XZEventGeneratorProtocol");
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		TAGDataLayer *dataLayer = [TAGManager instance].dataLayer;
		id<XZStoreProtocol> store = [[storeClass alloc] initWithHistoryLimit:maxHistoryItems];
		id<XZEventGeneratorProtocol> observer = [[eventGeneratorClass alloc] initWithDataLayer:dataLayer];
		id<XZStoreWriterProtocol> writer = [[XZDefaultStoreWriter alloc] initWithStore:store];
		sharedInstance = [[XZDataLayerViewer alloc] initWithStore:store writer:writer dataLayerObserver:observer];
		[observer addObserver:sharedInstance.observerBlock];
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

- (XZEventObservingBlock)observerBlock{
	__weak typeof(self) weakSelf = self;
	return ^(id<NSObject,NSCoding,NSCopying> eventData) {
		__strong typeof(weakSelf) strongSelf = weakSelf;
		[strongSelf.writer writeDataCopyToStore:eventData];
	};
}

@end
