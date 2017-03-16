//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZViewModel.h"

@interface XZViewModel ()
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *value;
@property(nonatomic,assign)BOOL shouldShowDisclosureIndicator;
@end

@implementation XZViewModel
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
