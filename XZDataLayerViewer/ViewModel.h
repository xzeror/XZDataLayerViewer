//
//  ViewModel.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@import Foundation;

@interface ViewModel : NSObject
@property(nonatomic,strong,readonly)NSString *key;
@property(nonatomic,strong,readonly)NSString *value;
@property(nonatomic,assign,readonly)BOOL shouldShowDisclosureIndicator;
- (instancetype)initWithKey:(NSString*)key value:(NSString*)value shouldShowDisclosureIndicator:(BOOL)shouldShowDisclosureIndicator NS_DESIGNATED_INITIALIZER;
@end
