//
//  ATDetailDescribeCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/30.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATDetailDescribeCellView.h"

@interface ATDetailDescribeCellView()
@property(nonatomic, strong) UILabel *requestDetail;
@end

@implementation ATDetailDescribeCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    UIView *line = [UIView new];
    line.backgroundColor = ATMainTonalColor;
    UILabel *requestInfo = [ATRoomInfoCellView createLabel:@"房间介绍" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    UIView *lineOne = [UIView new];
    line.backgroundColor = ATRGBA(239, 239, 245, 1.0);
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:requestInfo];
    [self.contentView addSubview:lineOne];
    [self.contentView addSubview: self.requestDetail];
    
    line.frame = CGRectMake(15, 15, 1, 12);
    requestInfo.frame = CGRectMake(20, 15, 70, 12);
    lineOne.frame = CGRectMake(15, 33, ATSCREEN_WIDTH - 30, 1);
    self.requestDetail.frame = CGRectMake(15, 40, ATSCREEN_WIDTH - 30, 100);
}

- (void)bindModel:(RoomInfo *)shareHouseJsonM {
    self.requestDetail.text = shareHouseJsonM.house_info_concat;
}

- (UILabel *)requestDetail {
    if (!_requestDetail) {
        _requestDetail = [ATCustomLabel new];
        //背景颜色为红色
        _requestDetail.backgroundColor = [UIColor whiteColor];
        //设置字体颜色为白色
        _requestDetail.textColor = [UIColor blackColor];
        //文字居中显示
        _requestDetail.textAlignment = NSTextAlignmentLeft | NSTextAlignmentNatural;
        //自动折行设置
        _requestDetail.lineBreakMode = NSLineBreakByWordWrapping;
        _requestDetail.numberOfLines = 0;
        [_requestDetail sizeToFit];

    }
    return _requestDetail;
}


@end
