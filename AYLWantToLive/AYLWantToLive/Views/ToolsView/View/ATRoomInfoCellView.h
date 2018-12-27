//
//  ATRoomInfoCellView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/29.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATRoomInfoCellView : UITableViewCell

- (void)bindModel:(RoomInfo *) shareHouseJsonM;

+ (UILabel *) createLabel:(NSString *)content fontSize:(CGFloat) size fontColor:(UIColor *) fontColor;

@end
