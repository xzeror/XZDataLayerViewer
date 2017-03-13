//
//  XZStoreWriter.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 07.03.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "Foundation/Foundation.h"

@protocol XZStoreProtocol;

@protocol XZStoreWriterProtocol
@property(nonatomic,strong,readonly)id<XZStoreProtocol> store;
- (id<XZStoreWriterProtocol>)initWithStore:(id<XZStoreProtocol>)store;
- (void)writeDataCopyToStore:(id<NSObject,NSCopying,NSCoding>)data;
@end
