//
//  ATMyInfoCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/5.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATMyInfoCellView.h"

@interface ATMyInfoCellView()

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *content;

@end

@implementation ATMyInfoCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)layoutSubviews {
    UIView *view = [UIView new];
    view.backgroundColor = ATDefaultBackgroundColor;
    
    [self.contentView addSubview: self.title];
    [self.contentView addSubview:self.content];
    [self.contentView addSubview:view];
    
    self.title.frame = CGRectMake(15, 5, 90, 30);
    self.content.frame = CGRectMake(ATSCREEN_WIDTH - 165 , 5, 150, 30);
    view.frame = CGRectMake(15, 43.5, ATSCREEN_WIDTH -30, 1);
    
}

- (void) bindTitle:(NSString *)title content:(NSString *) content {
    self.title.text = title;
    self.content.text = content;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont systemFontOfSize:12.0f];
    }
    return _title;
}

- (UILabel *)content {
    if (!_content) {
        _content = [UILabel new];
        _content.textAlignment = NSTextAlignmentRight;
        _content.font = [UIFont systemFontOfSize:14.0f];
    }
    return _content;
}

@end
