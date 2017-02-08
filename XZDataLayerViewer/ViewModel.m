//
//  ViewModel.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel ()
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *value;
@property(nonatomic,assign)BOOL shouldShowDisclosureIndicator;
@end

@implementation ViewModel
- (instancetype)init{
	return [self initWithKey:nil value:nil shouldShowDisclosureIndicator:NO];
}

- (instancetype)initWithKey:(NSString*)key value:(NSString*)value shouldShowDisclosureIndicator:(BOOL)shouldShowDisclosureIndicator{
	self = [super init];
	if(self != nil){
		_key = key;
		_value = value;
		_shouldShowDisclosureIndicator = shouldShowDisclosureIndicator;
	}
	return self;
}
@end
