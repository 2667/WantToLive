//
//  ATCollectionCell.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/24.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATCollectionCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIButton *deleteBtn;
@property(nonatomic, assign) NSInteger row;
@property(nonatomic, strong) id asset;


@end
