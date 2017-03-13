//
//  ViewController.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZDataSourceProtocol;

@interface XZViewerInterface : UITableViewController
@property(nonatomic,strong,readonly)id<XZDataSourceProtocol> dataSource;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(id<XZDataSourceProtocol>)dataSource NS_DESIGNATED_INITIALIZER;
- (void)refresh;
@end

