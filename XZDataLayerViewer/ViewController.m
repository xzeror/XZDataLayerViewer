//
//  ViewController.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "ViewController.h"
#import "DataSourceProtocol.h"
#import "ViewModel.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"
#import "DataSourceFabric.h"

@interface ViewController ()
@property(nonatomic,strong)id<DataSourceProtocol> dataSource;
@end

@implementation ViewController
- (instancetype)initWithDataSource:(id<DataSourceProtocol>)dataSource{
	self = [super init];
	if (self != nil) {
		_dataSource = dataSource;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass(self.class)];
	}
	
	ViewModel *viewModel = [self.dataSource viewModelForIndexPath:indexPath];
	if (viewModel.shouldShowDisclosureIndicator) {
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		cell.textLabel.text = viewModel.key;
		cell.detailTextLabel.text = nil;
	}
	else{
		[cell setAccessoryType:UITableViewCellAccessoryNone];
		cell.textLabel.text = viewModel.key;
		cell.detailTextLabel.text = viewModel.value;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	id rawData = [self.dataSource rawDataForIndexPath:indexPath];
	id<DataSourceProtocol> dataSource = [DataSourceFabric dataSourceForData:rawData];
	[self.navigationController pushViewController:[[ViewController alloc] initWithDataSource:dataSource] animated:YES];
}

- (void)refresh{
	[self.tableView reloadData];
}



//- (NSString*)valueToString:(id)value{
//	if ([value respondsToSelector:@selector(stringValue)]) {
//		return [value stringValue];
//	}
//	if([value isKindOfClass:[NSString class]]){
//		return value;
//	}
//	
//}

@end
