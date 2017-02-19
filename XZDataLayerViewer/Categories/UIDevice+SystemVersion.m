//
//  UIDevice+SystemVersion.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 19/02/17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "UIDevice+SystemVersion.h"

@implementation UIDevice (SystemVersion)
- (BOOL)isSystemVersionLessThan:(NSString*)version{
	BOOL result = ([self.systemVersion compare:version options:NSNumericSearch] == NSOrderedAscending);
	return result;
}
@end
