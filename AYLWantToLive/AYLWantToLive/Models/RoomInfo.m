//
//  RoomInfo.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/26.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "RoomInfo.h"

@implementation RoomInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"virtualNumber" : @"virtual",
             @"nshelves":@"new_shelves"
             };
}

@end
