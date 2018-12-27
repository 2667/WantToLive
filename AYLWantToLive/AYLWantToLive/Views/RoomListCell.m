//
//  RoomListCell.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/19.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "RoomListCell.h"
#import "RoomInfo.h"

@interface RoomListCell()

@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *cdese;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIView *subline;
@property (weak, nonatomic) IBOutlet UILabel *subDes;

@end

@implementation RoomListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(RoomInfo *)model{
    
    [self.name setText:model.subdistrict_name];
    [self.desc setText:model.house_info_concat];
    [self.price setText:[NSString stringWithFormat:@"￥%@", model.month_rent]];
    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:model.house_main_image]];
    NSString *string = [model.labels componentsJoinedByString:@","];
    [self.cdese setText:string];
    
    if (model.subway_desc.length > 0) {
        [self.subDes setText:model.subway_desc];
        [self.subDes setHidden:NO];
    }else{
        [self.subDes setHidden:YES];
    }
    
}

@end
