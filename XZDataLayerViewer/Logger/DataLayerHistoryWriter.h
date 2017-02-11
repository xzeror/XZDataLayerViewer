//
//  DataLayerHistoryWriter.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StoreProtocol;

@interface DataLayerHistoryWriter : NSObject
- (instancetype)initWithStore:(id<StoreProtocol>)store;
@end
