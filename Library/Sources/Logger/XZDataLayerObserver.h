//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZEventGeneratorProtocol.h"

@class TAGDataLayer;

/**
 *  Default event generator
 *	
 *	It monitors push to Google Tag Manager and generates events for this
 */
@interface XZDataLayerObserver : NSObject<XZEventGeneratorProtocol>
@property(nonatomic,weak,readonly)TAGDataLayer *dataLayer;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer NS_DESIGNATED_INITIALIZER;
@end
