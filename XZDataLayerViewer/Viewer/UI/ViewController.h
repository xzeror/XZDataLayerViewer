//
//  ViewController.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataSourceProtocol;

@interface ViewController : UITableViewController
@property(nonatomic,strong,readonly)id<DataSourceProtocol> dataSource;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(id<DataSourceProtocol>)dataSource NS_DESIGNATED_INITIALIZER;
- (void)refresh;
@end

