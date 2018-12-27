//
//  ATRoomInfoCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/29.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATRoomInfoCellView.h"

@interface ATRoomInfoCellView()

@property(nonatomic, strong) UILabel *area;
@property(nonatomic, strong) UILabel *floor;
@property(nonatomic, strong) UILabel *number;
@property(nonatomic, strong) UILabel *time;
@property(nonatomic, strong) UILabel *houseType;
@property(nonatomic, strong) UILabel *decoration;

@end

@implementation ATRoomInfoCellView
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self layoutOfSubviews];
    }
    return self;
}

- (void)layoutOfSubviews {
    UIView *line = [UIView new];
    line.backgroundColor = ATMainTonalColor;
    UILabel *roomInfo = [ATRoomInfoCellView createLabel:@"房间信息" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    UILabel *area = [ATRoomInfoCellView createLabel:@"面积:" fontSize:16.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.area = [ATRoomInfoCellView createLabel:nil fontSize:16.0 fontColor:[UIColor blackColor]];
    UILabel *houseType = [ATRoomInfoCellView createLabel:@"户型:" fontSize:16.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.houseType = [ATRoomInfoCellView createLabel:nil fontSize:16.0 fontColor:[UIColor blackColor]];
    UILabel *floor = [ATRoomInfoCellView createLabel:@"楼层:" fontSize:16.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.floor = [ATRoomInfoCellView createLabel:nil fontSize:16.0 fontColor:[UIColor blackColor]];
    UILabel *decoration = [ATRoomInfoCellView createLabel:@"装修:" fontSize:16.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.decoration = [ATRoomInfoCellView createLabel:nil fontSize:16.0 fontColor:[UIColor blackColor]];
    UILabel *number = [ATRoomInfoCellView createLabel:@"编号:" fontSize:16.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.number = [ATRoomInfoCellView createLabel:nil fontSize:16.0 fontColor:[UIColor blackColor]];
    UILabel *time = [ATRoomInfoCellView createLabel:@"更新时间:" fontSize:16.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.time = [ATRoomInfoCellView createLabel:nil fontSize:16.0 fontColor:[UIColor blackColor]];
    
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:roomInfo];
    [self.contentView addSubview:area];
    [self.contentView addSubview:self.area];
    [self.contentView addSubview:houseType];
    [self.contentView addSubview:self.houseType];
    [self.contentView addSubview:floor];
    [self.contentView addSubview:self.floor];
    [self.contentView addSubview:decoration];
    [self.contentView addSubview:self.decoration];
    [self.contentView addSubview:number];
    [self.contentView addSubview:self.number];
    [self.contentView addSubview:time];
    [self.contentView addSubview:self.time];
    
    
    line.frame = CGRectMake(15, 15, 1, 12);
    roomInfo.frame = CGRectMake(20, 15, 70, 12);
    area.frame = CGRectMake(15, 42, 40, 15);
    self.area.frame = CGRectMake(55, 42, 70, 15);
    houseType.frame = CGRectMake(160, 42, 40, 15);
    self.houseType.frame = CGRectMake(200, 42, 90, 15);
    floor.frame = CGRectMake(15, 72, 40, 15);
    self.floor.frame = CGRectMake(55, 72, 90, 15);
    decoration.frame = CGRectMake(160, 72, 40, 15);
    self.decoration.frame = CGRectMake(200, 72, 90, 15);
    number.frame = CGRectMake(15, 102, 40, 15);
    self.number.frame = CGRectMake(55, 102, ATSCREEN_WIDTH - 70, 15);
    time.frame = CGRectMake(15, 132, 70, 15);
    self.time.frame = CGRectMake(95, 132, 100, 15);
}

- (void)bindModel:(RoomInfo *) shareHouseJsonM {
    self.area.text = shareHouseJsonM.rent_area;
    self.floor.text = shareHouseJsonM.floor_area;
    self.number.text = shareHouseJsonM.house_id;
    
  
    self.time.text = shareHouseJsonM.publish_date;
    
    self.houseType.text = shareHouseJsonM.house_info_concat_two;
    self.decoration.text = shareHouseJsonM.house_info_concat_two;
}

+ (UILabel *) createLabel:(NSString *)content fontSize:(CGFloat) size fontColor:(UIColor *) fontColor {
    UILabel *label = [UILabel new];
    [label setTextColor: fontColor];
    label.font = [UIFont systemFontOfSize:size];
    label.text = content;
    
    return label;
}

@end
