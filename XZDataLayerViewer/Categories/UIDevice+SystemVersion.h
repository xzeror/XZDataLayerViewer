//
//  UIDevice+SystemVersion.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 19/02/17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIDevice (SystemVersion)
- (BOOL)isSystemVersionLessThan:(NSString*)version;
@end
