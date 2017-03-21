//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZCommon.h"

@class XZViewModel;

/**
 *  DataSourceProtocol defines interface for different data sources 
 *  that allows interface to display available data
 */
@protocol XZDataSourceProtocol
/**
 *  Returns number of data objects available to read
 *
 *  @return number of data objects
 */
- (NSInteger)count;

/**
 *  Constructs viewModel for object at indexPath
 *
 *  @param indexPath indexPath of object
 *
 *  @return XZViewModel
 */
- (XZViewModel*)viewModelForIndexPath:(NSIndexPath*)indexPath;

/**
 *  Get raw data located at indexPath
 *
 *  @param indexPath indexPath of object
 *
 *  @return rawData
 */
- (id)rawDataForIndexPath:(NSIndexPath*)indexPath;
@end
