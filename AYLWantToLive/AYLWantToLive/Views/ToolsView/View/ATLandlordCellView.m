//
//  ATLandlordCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/30.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATLandlordCellView.h"

@interface ATLandlordCellView()

@property(nonatomic, strong) UIImageView *headImage;
@property(nonatomic, strong) UILabel *nickName;
@property(nonatomic, strong) UILabel *price;
@property(nonatomic, strong) UILabel *callUp;

@property(nonatomic, strong) UIView *lineOne;
@end

@implementation ATLandlordCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    UIView *line = [UIView new];
    line.backgroundColor = ATMainTonalColor;
    UILabel *landlordInfo = [ATRoomInfoCellView createLabel:@"房东信息" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.nickName = [ATRoomInfoCellView createLabel:nil fontSize:14.0 fontColor:[UIColor blackColor]];
    UILabel *rent = [ATRoomInfoCellView createLabel:@"每月房租" fontSize:12.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    UILabel *phoneNumber = [ATRoomInfoCellView createLabel:@"电话号码" fontSize:12.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.callUp = [ATRoomInfoCellView createLabel:nil fontSize:14.0 fontColor:[UIColor blackColor]];
    
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:landlordInfo];
    [self.contentView addSubview: self.headImage];
    [self.contentView addSubview: self.nickName];
    [self.contentView addSubview: rent];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:phoneNumber];
    [self.contentView addSubview:self.callUp];
    
    line.frame = CGRectMake(15, 15, 1, 12);
    landlordInfo.frame = CGRectMake(20, 15, 70, 12);
    self.headImage.frame = CGRectMake(15, 50, 40, 40);
    self.nickName.frame = CGRectMake(60, 62, 88, 15);
    rent.frame = CGRectMake(145, 45, 60, 12);
    self.price.frame = CGRectMake(145, 75, 60, 15);
    phoneNumber.frame = CGRectMake(ATSCREEN_WIDTH-105, 45, 60, 12);
    self.callUp.frame = CGRectMake(ATSCREEN_WIDTH-105, 75, 90, 15);
}

- (void)bindModel:(RoomInfo *)shareHouseJsonM {
    self.price.text = [NSString stringWithFormat:@"%@￥",shareHouseJsonM.month_rent];
    
//    ATMyHeadModel *myHeadM = [RoomInfo userOrLandlordInfoByID:shareHouseJsonM.house_id];
    self.nickName.text = shareHouseJsonM.lanName;
//    self.headImage.image = [ATTools readPictureFromAbsolutePath:myHeadM.avatarPath];
    self.callUp.text = shareHouseJsonM.lanNum;
}

- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [UIImageView new];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = 20.0;
    }
    return _headImage;
}

- (UILabel *)price {
    if (!_price) {
        _price = [UILabel new];
        _price.font = [UIFont systemFontOfSize:18.0];
        [_price setTextColor:ATRGBA(134, 213, 106, 1.0)];
        _price.textAlignment = NSTextAlignmentCenter;
    }
    return _price;
}

@end
