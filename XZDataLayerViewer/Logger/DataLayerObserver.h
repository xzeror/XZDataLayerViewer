//
//  DataLayerObserver.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TAGDataLayer;

extern NSString * const DataLayerHasChangedNotification;
extern NSString * const kDataLayerPayload;

@interface DataLayerObserver : NSObject
-(instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer NS_DESIGNATED_INITIALIZER;
@end