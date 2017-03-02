//
//  ArrayDataSource.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@import Foundation;
#import "DataSourceProtocol.h"

@interface ArrayDataSource : NSObject <DataSourceProtocol>
- (instancetype)initWithArray:(NSArray*)array NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end
