//
//  AYLDetailViewController.h
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/26.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "AYLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class RoomInfo;

@interface AYLDetailViewController : AYLBaseViewController


@property(nonatomic, strong)RoomInfo *model;

@end

NS_ASSUME_NONNULL_END
