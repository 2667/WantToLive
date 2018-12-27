//
//  ATFacilityCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/29.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATFacilityCellView.h"

@implementation ATFacilityCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//       UIView *view = [self createFacility:@[@"电脑桌"] index:0];
//        [self.contentView addSubview:view];
    }
    return self;
}

- (void)layoutSubviews {
    UIView *line = [UIView new];
    line.backgroundColor = ATMainTonalColor;
    UILabel *facilitiesInfo = [ATRoomInfoCellView createLabel:@"设施信息" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:facilitiesInfo];
    
    line.frame = CGRectMake(15, 15, 1, 12);
    facilitiesInfo.frame = CGRectMake(20, 15, 70, 12);
}

- (void)bindModel:(RoomInfo *) shareHouseJsonM {
    [self layoutOfSubviewsWithFacilities:shareHouseJsonM.labels];
}

- (void)layoutOfSubviewsWithFacilities:(NSArray *) facilities {
//    NSArray *array = self.shareHouseJsonM.la;//[facilities componentsSeparatedByString:@","];
    for (int i = 0; i < facilities.count; i ++) {
        UIView *view = [self createFacility:facilities index:i];
        [self.contentView addSubview:view];
    }
    
}

- (UIView *) createFacility:(NSArray *)array index:(int) i {
    
    CGFloat widthV = (ATSCREEN_WIDTH - 20*6)/5;
    CGFloat xV = (i%5 +1) *20 + (i%5)*widthV;
    CGFloat heightV = 44;
    CGFloat yV = 42 + (i / 5)*heightV;
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(xV, yV, widthV, heightV)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array[i]]];
    imageView.frame = CGRectMake(9, 0, 22, 22);
    UILabel *title = [ATRoomInfoCellView createLabel:array[i] fontSize:12.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    title.frame = CGRectMake(0, 22, 40, 15);
    title.textAlignment = NSTextAlignmentCenter;
                             
    [view addSubview:imageView];
    [view addSubview:title];
    return view;
}

@end
