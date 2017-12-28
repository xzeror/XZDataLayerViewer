//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZViewerInterface.h"
#import "XZDataSourceProtocol.h"
#import "XZViewModel.h"
#import "XZDataSourceFabric.h"
#import "XZViewerTableViewCell.h"

static NSString *const kAnalyticsItemCellReuseID = @"kAnalyticsItemCellReuseID";

@interface XZViewerInterface ()
@property(nonatomic,strong)id<XZDataSourceProtocol> dataSource;
@end

@implementation XZViewerInterface
- (instancetype)initWithDataSource:(id<XZDataSourceProtocol>)dataSource{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		_dataSource = dataSource;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
	}
	return self;
}

- (void)viewDidLoad{
	[super viewDidLoad];
    
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:XZViewerTableViewCell.class forCellReuseIdentifier:kAnalyticsItemCellReuseID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZViewerTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kAnalyticsItemCellReuseID];
    if (!cell) {
        cell = [[XZViewerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAnalyticsItemCellReuseID];
    }
    
    XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:indexPath];
    if (viewModel == nil) {
        cell.textLabel.text = @"empty";
        return cell;
    }
    
    cell.title = viewModel.key;
    cell.subtitle = viewModel.shouldShowDisclosureIndicator ? nil : viewModel.value;
    [cell setAccessoryType:viewModel.shouldShowDisclosureIndicator ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row >= [self.dataSource count]) {
		return;
	}
	id rawData = [self.dataSource rawDataForIndexPath:indexPath];
	if (rawData == nil) {
		return;
	}
//	//TODO: DataSourceFabric is impilicit dependency
	id<XZDataSourceProtocol> dataSource = [XZDataSourceFabric dataSourceForData:rawData];
	if (dataSource == nil) {
		return;
	}
	[self.navigationController pushViewController:[[XZViewerInterface alloc] initWithDataSource:dataSource] animated:YES];
}

#pragma mark - Auxiliary methods

- (void)refresh{
	[self.tableView reloadData];
	[self.refreshControl endRefreshing];
}

- (void)dismiss{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
