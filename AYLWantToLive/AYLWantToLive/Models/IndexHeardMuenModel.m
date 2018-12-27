//
//  IndexHeardMuenModel.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/25.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "IndexHeardMuenModel.h"

@implementation IndexHeardMuenModel
static IndexHeardMuenModel *_instance;

+(IndexHeardMuenModel*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil)_instance = [[IndexHeardMuenModel alloc] init];
    });
    return _instance;
}

@end
