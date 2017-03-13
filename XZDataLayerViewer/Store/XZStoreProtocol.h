//
//  StoreProtocol.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@protocol XZStoreProtocol
@property(nonatomic,assign)NSUInteger historyLimit;
- (instancetype)initWithHistoryLimit:(NSUInteger)historyLimit;
- (id)addObject:(id)object;
- (id)objectWithId:(id)identifier;
- (NSUInteger)objectsCount;
- (NSArray*)objects;
@end
