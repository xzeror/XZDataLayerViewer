//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZDefaultStoreWriter.h"
#import "XZStoreProtocol.h"
#import "XZEventHistoryElement.h"

@interface XZDefaultStoreWriter ()
@property(nonatomic,strong)id<XZStoreProtocol> store;
@end

@implementation XZDefaultStoreWriter
- (instancetype)initWithStore:(id<XZStoreProtocol>)store{
	if((self = [super init])){
		_store = store;
	}
	return self;
}

- (void)writeDataCopyToStore:(id<NSObject,NSCopying,NSCoding>)data{
	if (data == nil) {
		return;
	}
	XZEventHistoryElement *eventHistoryElement = [[XZEventHistoryElement alloc] initWithData:data];
	if (eventHistoryElement == nil) {
		return;
	}
	[self.store addObject:eventHistoryElement];
}

@end
