//
//  CustomPickerView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/4.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) NSMutableArray *pickerArray;

@end

@implementation CustomPickerView


- (instancetype)initWithFrame:(CGRect)frame pickerArray:(NSMutableArray *) pickerArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerArray = pickerArray;
        [self addSubview:self.pickerView];
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSMutableArray *pickers = self.pickerArray[component];
    return pickers.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return  25.0f;
}

//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return  self.frame.size.width/self.pickerArray.count;
    
}

//自定义指定列的每行的视图，即指定列的每行的视图行为一致

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (!view){
        
        view = [[UIView alloc]init];
        
    }
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/self.pickerArray.count, 20)];
    
    text.textAlignment = NSTextAlignmentCenter;
    NSMutableArray *components  = self.pickerArray[component];
//    label.text = [NSString stringWithFormat:@"%@",components[row]];
    text.text = [components objectAtIndex:row];
    
    
    //隐藏上下直线
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
//    view.backgroundColor = [UIColor redColor];
    
    return text;
    
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    NSLog(@"HANG%@",[self.pickerArray objectAtIndex:row]);
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.userInteractionEnabled = YES;
    }
    return _pickerView;
}

@end
