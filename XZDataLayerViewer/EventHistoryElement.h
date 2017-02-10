//
//  EventHistoryElement.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventHistoryElement : NSObject
@property(nonatomic,strong,readonly)NSDictionary *dataLayerModel;
@property(nonatomic,strong,readonly)NSDate *timestamp;
- (instancetype)initWithDataLayerModel:(NSDictionary*)dataLayerModel;
@end
