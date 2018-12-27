//
//  ATPickerView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/17.
//  Copyright © 2018年 Harely. All rights reserved.
// [self.lzPickerView selectRow:j inComponent:1 animated:NO]; 定位到某 component 列，第 row行，这是针对于某一行

#import "ATPickerView.h"

@interface ATPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

//表盘数组
@property(nonatomic, strong) NSMutableArray *dialplateArrays;
//表盘默认值
@property(nonatomic, strong) NSMutableArray *dialplateDefaultValues;

//背景图
@property(nonatomic, strong) UIView *bgVIew;
//PickerView 不能用懒加载否则不显示
@property(nonatomic, strong) UIPickerView *lzPickerView;
//工具图
@property(nonatomic, strong) UIView *toolBgView;

//确定/取消按钮/标题
@property(nonatomic, strong) UIButton *cancelBtn;
@property(nonatomic, strong) UIButton *sureBtn;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic) int pickerHeight;
@property(nonatomic) int bgViewHeight;


@end

@implementation ATPickerView

- (instancetype)initWithFrame:(CGRect)frame  pickerTitle:(NSString *)title rollArrays:(NSMutableArray *)rollsData defaultValue:(NSString *) defaultValue {
    self = [super initWithFrame:frame];
    if (self) {
        self.dialplateArrays = rollsData;
        self.titleLabel.text = title;
        [self getDialplateDefaultValues:defaultValue];
//        给底层的背景颜色,也可以保证子控件不透明
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        self.pickerHeight = 260;
        self.bgViewHeight = 300;
        
        self.lzPickerView = [[UIPickerView alloc] init];
        self.lzPickerView.backgroundColor = [UIColor whiteColor];
        
        self.lzPickerView.delegate = self;
        self.lzPickerView.dataSource = self;
    }
    [self layoutIfNeeded];
    return self;
}

#pragma mark - UIPickerViewDelegate
//有几个表盘
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return self.dialplateArrays.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

//选中时回调的委托方法
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selectComponent = nil;
    for (int i = 0; i < self.dialplateArrays.count; i ++) {
        NSMutableArray *details = self.dialplateArrays[component];
        if (i == component) {
            selectComponent = [NSString stringWithFormat:@"%@", details[row]];//获取选中的值；
            self.dialplateDefaultValues[component] = selectComponent;
        }
    }
    NSLog(@"-------++++++++++++++------->%@", self.dialplateDefaultValues);
}

//对pickerview进行样式定义

/**
@param pickerView 表盘视图
 @param row 表盘的行
 @param component 第几列表盘
 @param view 返回的表盘视图
 @return 返回自定义表盘
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = ATDefaultColor;
        }
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 7, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];

    NSMutableArray *components  = self.dialplateArrays[component];
    label.text = [NSString stringWithFormat:@"%@",components[row]];
    return label;
}


#pragma mark - UIPickerViewDataSource
//每个表盘上有多少行数据
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSMutableArray *deatail = self.dialplateArrays[component];
    return deatail.count;
}

//弹出PickerView
- (void) popubPickerView {
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    //动画出现 320 568
    CGRect frame = self.bgVIew.frame;
    NSLog(@"--->> %f", [[UIScreen mainScreen] bounds].size.height);
    if (frame.origin.y == ATSCREEN_HEIGHT) {
        frame.origin.y -= self.bgViewHeight;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgVIew.frame = frame;
        }];
    }
}


#pragma mark - ActionMethod
//移除PickerView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeSelfFromSupView];
}

- (void) cancelAction {
    [self removeSelfFromSupView];
}

- (void) okAction {
    if (self.selectValue) {
        self.selectValue(self.dialplateDefaultValues);
    }
    [self removeSelfFromSupView];
}

- (void)removeSelfFromSupView
{
    CGRect selfFrame = self.bgVIew.frame;
    if (selfFrame.origin.y == ATSCREEN_HEIGHT - self.bgViewHeight) {
        selfFrame.origin.y += self.bgViewHeight;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgVIew.frame = selfFrame;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)layoutSubviews {
    [self addSubview:self.bgVIew];
    
    self.lzPickerView.frame = CGRectMake(0, 50, ATSCREEN_WIDTH, self.pickerHeight);
    [self.bgVIew addSubview:self.lzPickerView];

    
    [self.bgVIew addSubview:self.toolBgView];
    self.toolBgView.frame = CGRectMake(0, 0, ATSCREEN_WIDTH, 50);
    
    [self.toolBgView addSubview:self.cancelBtn];
    [self.toolBgView addSubview:self.sureBtn];
    [self.toolBgView addSubview:self.titleLabel];
    
    self.cancelBtn.frame = CGRectMake(15, 5, 46, 40);
    self.sureBtn.frame = CGRectMake(ATSCREEN_WIDTH - 61, 5, 46, 40);
    self.titleLabel.frame = CGRectMake(61, 5, ATSCREEN_WIDTH - (61 *2), 40);
}

#pragma mark - 对默认值进行处理
- (NSMutableArray *) getDialplateDefaultValues:(NSString *)defaultValue {
    self.dialplateDefaultValues = [NSMutableArray array];
    if (defaultValue != nil) {
        NSArray *values = [defaultValue componentsSeparatedByString:@","];
        for (int i = 0; i < values.count; i ++) {
            [self.dialplateDefaultValues addObject:values];
        }
    }else {
        for (int i = 0; i < self.dialplateArrays.count; i ++) {
            NSMutableArray *next = self.dialplateArrays[i];
            [self.dialplateDefaultValues addObject: next[0]];
        }
    }
    return self.dialplateDefaultValues;
}
#pragma mark - 初始化UI
- (UIView *)bgVIew {
    if (!_bgVIew) {
        _bgVIew = [[UIView alloc] initWithFrame:CGRectMake(0, ATSCREEN_HEIGHT, ATSCREEN_WIDTH, self.bgViewHeight)];
        _bgVIew.backgroundColor = [UIColor greenColor];
    }
    return _bgVIew;
}

- (UIView *)toolBgView {
    if (!_toolBgView) {
        _toolBgView = [[UIView alloc] init];
        _toolBgView.backgroundColor = ATMainTonalColor;
    }
    return _toolBgView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *) sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
