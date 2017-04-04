//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZCommon.h"

@protocol XZDataSourceProtocol;

/**
 *  Interface that can be used bu user to view saved data
 */
@interface XZViewerInterface : UITableViewController
/**
 *  Data source used by view controller to get diplayed data
 */
@property(nonatomic,strong,readonly)id<XZDataSourceProtocol> dataSource;

/**
 *  Designated initializer
 *
 *  @param dataSource data source
 *
 *  @return instance of UIViewController
 */
- (instancetype)initWithDataSource:(id<XZDataSourceProtocol>)dataSource NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewStyle)style NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Reload data from data source and refresh diplayed data on screen
 */
- (void)refresh;

/**
 *  Dismiss viewer interface
 */
- (void)dismiss;
@end

