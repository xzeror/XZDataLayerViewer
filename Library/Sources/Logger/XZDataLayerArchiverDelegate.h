//  Created by Andrey Ostanin on 02.04.17.
//  Copyright © 2017 XZone Software. All rights reserved.

/**
 *  Custom NSKeyedArchiverDelegate
 *  Used to replace kDataLayerObjectNotPresent to custom object
 *  during deep data layer copy operation
 */
@interface XZDataLayerArchiverDelegate : NSObject<NSKeyedArchiverDelegate>
- (id)archiver:(NSKeyedArchiver *)archiver willEncodeObject:(id)object;
@end
