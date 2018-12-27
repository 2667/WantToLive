//
//  ATPickerView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/17.
//  Copyright © 2018年 Harely. All rights reserved.
//借鉴资料：http://code.cocoachina.com/view/136805

#import <UIKit/UIKit.h>

@interface ATPickerView : UIView

//回调结果值
@property(nonatomic, copy) void(^selectValue)(NSMutableArray *values);

/**
 初始化选择器

 @param frame 选择器大小
 @param title 选择器标题
 @param rollsData 表盘数组
 @param defaultValue 表盘默认值
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame  pickerTitle:(NSString *)title rollArrays:(NSMutableArray *)rollsData defaultValue:(NSString *) defaultValue;

//弹出选择器视图
- (void) popubPickerView;

@end
