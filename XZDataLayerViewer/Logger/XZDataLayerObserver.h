//
//  DataLayerObserver.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZEventGeneratorProtocol.h"

@class TAGDataLayer;

@interface XZDataLayerObserver : NSObject<XZEventGeneratorProtocol>
@property(nonatomic,weak,readonly)TAGDataLayer *dataLayer;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer NS_DESIGNATED_INITIALIZER;
@end
