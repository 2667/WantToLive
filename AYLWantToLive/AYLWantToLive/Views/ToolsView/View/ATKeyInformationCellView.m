//
//  ATKeyInformationCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/29.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATKeyInformationCellView.h"

@interface ATKeyInformationCellView()

@property(nonatomic, strong) UILabel *rentType;
@property(nonatomic, strong) UILabel *price;
@property(nonatomic, strong) UILabel *pricePostfix;
@property(nonatomic, strong) UILabel *houseType;
@property(nonatomic, strong) UILabel *area;
@property(nonatomic, strong) UILabel *direction;
@property(nonatomic, strong) UILabel *onHireDuration;
@property(nonatomic, strong) UILabel *singleToilet;
@property(nonatomic, strong) UILabel *paymentWays;
@property(nonatomic, strong) UILabel *decorated;

@property(nonatomic, strong) UIView *lineOne;
@property(nonatomic, strong) UIView *lineTwo;
@property(nonatomic, strong) UIView *lineThree;
@property(nonatomic, strong) UIView *lineFour;
@property(nonatomic, strong) UIView *lineFive;

@end

@implementation ATKeyInformationCellView
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [self.contentView addSubview:self.rentType];
    [self.contentView addSubview:self.lineOne];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.pricePostfix];
    [self.contentView addSubview:self.lineTwo];
    [self.contentView addSubview:self.houseType];
    [self.contentView addSubview:self.lineThree];
    [self.contentView addSubview:self.area];
    [self.contentView addSubview:self.lineFour];
    [self.contentView addSubview:self.direction];
    [self.contentView addSubview:self.lineFive];
    [self.contentView addSubview:self.onHireDuration];
    [self.contentView addSubview:self.paymentWays];
    [self.contentView addSubview:self.decorated];
    [self.contentView addSubview:self.singleToilet];
    
    self.rentType.frame = CGRectMake(15, 16, ATSCREEN_WIDTH-2*15, 18);
    self.lineOne.frame = CGRectMake(15, 49, ATSCREEN_WIDTH - 2*15, 1);
    self.price.frame = CGRectMake(15, 60, 50, 18);
    self.pricePostfix.frame = CGRectMake(65, 63, 38, 15);
    self.lineTwo.frame = CGRectMake(115, 60, 1, 18);
    self.houseType.frame = CGRectMake(130, 60, 40, 18);
    self.lineThree.frame = CGRectMake(172, 60, 1, 18);
    self.area.frame = CGRectMake(175, 60, 80, 18);
    self.lineFour.frame = CGRectMake(260, 60, 1, 18);
    self.direction.frame = CGRectMake(ATSCREEN_WIDTH - 55, 60, 40, 18);
    self.lineFive.frame = CGRectMake(15, 88, ATSCREEN_WIDTH - 2*15, 1);
    self.onHireDuration.frame = CGRectMake(15, 103, 60, 23);
    self.paymentWays.frame = CGRectMake(80, 103, 80, 23);
    self.decorated.frame = CGRectMake(165, 103, 80, 23);
    self.singleToilet.frame = CGRectMake(250, 103, 40, 23);
}

- (void)bindModel:(RoomInfo *) shareHouseJosnM {
    self.rentType.text = shareHouseJosnM.subdistrict_name;
    self.price.text = shareHouseJosnM.month_rent;
    
    if ([@"整租" rangeOfString:shareHouseJosnM.room_type].length > 0) {
        self.houseType.text = @"整套";
    }else {
        self.houseType.text = @"合租";
    }
    
    self.area.text = [NSString stringWithFormat:@"%@㎡",shareHouseJosnM.rent_area];
//    self.direction.text = shareHouseJosnM.orientation;
    self.onHireDuration.text = @"可短租";
    self.paymentWays.text = shareHouseJosnM.labels[0];
    self.decorated.text = shareHouseJosnM.subdistrict_name;
    self.singleToilet.text= @"月付";
}

- (UILabel *)rentType {
    if (!_rentType) {
        _rentType = [UILabel new];
    }
    return _rentType;
}

- (UILabel *)houseType {
    if (!_houseType) {
        _houseType = [UILabel new];
    }
    return _houseType;
}
- (UILabel *)price {
    if (!_price) {
        _price = [UILabel new];
        _price.font = [UIFont systemFontOfSize:18.0];
        [_price setTextColor:ATRGBA(134, 213, 106, 1.0)];
        _price.textAlignment = NSTextAlignmentRight;
    }
    return _price;
}

- (UILabel *)pricePostfix {
    if (!_pricePostfix) {
        _pricePostfix = [UILabel new];
        _pricePostfix.text = @"元/月起";
        _pricePostfix.textAlignment = NSTextAlignmentLeft;
        _pricePostfix.font = [UIFont systemFontOfSize:10.0];
        [_pricePostfix setTextColor:ATRGBA(229, 138, 38, 0.9)];
    }
    return _pricePostfix;
}
- (UILabel *)area {
    if (!_area) {
        _area = [UILabel new];
        _area.textAlignment = NSTextAlignmentCenter;
    }
    return _area;
}
- (UILabel *)direction {
    if (!_direction) {
        _direction = [UILabel new];
        _direction.textAlignment = NSTextAlignmentCenter;
    }
    return _direction;
}
- (UILabel *)paymentWays {
    if (!_paymentWays) {
        _paymentWays = [UILabel new];
        [_paymentWays setTextColor:ATRGBA(171, 179, 186, 1.0)];
        _paymentWays.textAlignment = NSTextAlignmentCenter;
        _paymentWays.layer.masksToBounds = YES;
        _paymentWays.layer.cornerRadius = 5.0;
        _paymentWays.layer.borderWidth = 1.0;
        _paymentWays.layer.borderColor = ATRGBA(171, 179, 186, 1.0).CGColor;
    }
    return _paymentWays;
}
- (UILabel *)decorated {
    if (!_decorated) {
        _decorated = [UILabel new];
        [_decorated setTextColor:ATRGBA(171, 179, 186, 1.0)];
        _decorated.textAlignment = NSTextAlignmentCenter;
        _decorated.layer.masksToBounds = YES;
        _decorated.layer.cornerRadius = 5.0;
        _decorated.layer.borderWidth = 1.0;
        _decorated.layer.borderColor = ATRGBA(171, 179, 186, 1.0).CGColor;
    }
    return _decorated;
}
- (UILabel *)singleToilet {
    if (!_singleToilet) {
        _singleToilet = [UILabel new];
        [_singleToilet setTextColor:ATRGBA(171, 179, 186, 1.0)];
        _singleToilet.textAlignment = NSTextAlignmentCenter;
        _singleToilet.layer.masksToBounds = YES;
        _singleToilet.layer.cornerRadius = 5.0;
        _singleToilet.layer.borderWidth = 1.0;
        _singleToilet.layer.borderColor = ATRGBA(171, 179, 186, 1.0).CGColor;
    }
    return _singleToilet;
}
- (UILabel *)onHireDuration {
    if (!_onHireDuration) {
        _onHireDuration = [UILabel new];
        [_onHireDuration setTextColor:ATRGBA(171, 179, 186, 1.0)];
        _onHireDuration.textAlignment = NSTextAlignmentCenter;
        _onHireDuration.layer.masksToBounds = YES;
        _onHireDuration.layer.cornerRadius = 5.0;
        _onHireDuration.layer.borderWidth = 1.0;
        _onHireDuration.layer.borderColor = ATRGBA(171, 179, 186, 1.0).CGColor;
    }
    return _onHireDuration;
}

- (UIView *)lineOne {
    if (!_lineOne) {
        _lineOne = [UIView new];
        _lineOne.backgroundColor = ATRGBA(238, 238, 245, 1.0);
    }
    return _lineOne;
}
- (UIView *)lineTwo {
    if (!_lineTwo) {
        _lineTwo = [UIView new];
        _lineTwo.backgroundColor = ATRGBA(238, 238, 245, 1.0);
    }
    return _lineTwo;
}
- (UIView *)lineFive {
    if (!_lineFive) {
        _lineFive = [UIView new];
        _lineFive.backgroundColor = ATRGBA(238, 238, 245, 1.0);
    }
    return _lineFive;
}
- (UIView *)lineThree {
    if (!_lineThree) {
        _lineThree = [UIView new];
        _lineThree.backgroundColor = ATRGBA(238, 238, 245, 1.0);
    }
    return _lineThree;
}
- (UIView *)lineFour {
    if (!_lineFour) {
        _lineFour = [UIView new];
        _lineFour.backgroundColor = ATRGBA(238, 238, 245, 1.0);
    }
    return _lineFour;
}

@end
