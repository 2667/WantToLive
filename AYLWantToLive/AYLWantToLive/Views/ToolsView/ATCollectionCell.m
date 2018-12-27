//
//  ATCollectionCell.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/24.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATCollectionCell.h"

#import <Photos/Photos.h>

@implementation ATCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        就是当它取值为 YES 时，剪裁超出父视图范围的子视图部分；当它取值为 NO 时，不剪裁子视图。
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.deleteBtn];
//    CGFloat HOrW = self.frame.size.width;
    
    _imageView.frame = self.bounds;
    _deleteBtn.frame = CGRectMake(self.frame.size.width - 36, 0, 36, 36);
}

#pragma mark - CreateUI
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        _deleteBtn.alpha = 0.6;
    }
    return _deleteBtn;
}

- (void) setAsset:(id) asset {
    _asset = asset;
    if ([asset isKindOfClass:[PHAsset class]]) {
//        PHAsset *phAsset = asset;
        
    }
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}

@end
