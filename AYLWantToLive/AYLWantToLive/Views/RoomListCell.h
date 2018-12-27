//
//  RoomListCell.h
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/19.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RoomInfo;

@interface RoomListCell : UITableViewCell

@property(nonatomic, strong)RoomInfo *model;

@end

NS_ASSUME_NONNULL_END
