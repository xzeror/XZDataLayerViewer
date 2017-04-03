//  Created by Andrey Ostanin on 28.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "TAGDataLayer+CustomProperties.h"
#import "XZDataLayerArchiverDelegate.h"

static NSString * const DataLayerModelPropertyName = @"model";

@implementation TAGDataLayer (CustomProperties)
- (NSDictionary*)dataLayerModelDeepCopy{
	NSDictionary *dataLayerModel = (NSDictionary*)[self valueForKey:DataLayerModelPropertyName];
	NSAssert(dataLayerModel, @"Error! TAGDataLayer model is not available with KVC key 'model'");
	
	NSMutableData *archive = [[NSMutableData alloc] init];
	XZDataLayerArchiverDelegate *delegate = [[XZDataLayerArchiverDelegate alloc] init];
	NSKeyedArchiver *archiever = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archive];
	archiever.delegate = delegate;
	[archiever encodeObject:dataLayerModel forKey:NSKeyedArchiveRootObjectKey];
	[archiever finishEncoding];
	NSDictionary *dataLayerModelDeepCopy = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	return dataLayerModelDeepCopy;
}
@end


