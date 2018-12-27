//
//  CustomPickerView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/4.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickerView : UIPickerView

@property(nonatomic, copy) void(^selectValue)(NSMutableArray *values);


- (instancetype)initWithFrame:(CGRect)frame pickerArray:(NSMutableArray *) pickerArray;

@end
