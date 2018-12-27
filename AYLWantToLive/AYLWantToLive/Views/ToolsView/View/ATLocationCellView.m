//
//  ATLocationCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/29.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATLocationCellView.h"

@interface ATLocationCellView()

@property(nonatomic, strong) UILabel *location;

@end

@implementation ATLocationCellView

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
    UILabel *roomInfo = [ATRoomInfoCellView createLabel:@"地区信息" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    UILabel *location = [ATRoomInfoCellView createLabel:@"地区:" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    self.location = [ATRoomInfoCellView createLabel:nil fontSize:14.0 fontColor:[UIColor blackColor]];
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:roomInfo];
    [self.contentView addSubview:location];
    [self.contentView addSubview:self.location];

    line.frame = CGRectMake(15, 15, 1, 12);
    roomInfo.frame = CGRectMake(20, 15, 70, 12);
    location.frame = CGRectMake(15, 42, 40, 15);
    self.location.frame = CGRectMake(55, 42, 250, 15);

}

- (void)bindModel:(RoomInfo *) shareHouseJsonM{
    self.location.text = shareHouseJsonM.latlon;
}
@end
