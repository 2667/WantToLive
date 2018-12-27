//
//  IndexHeardMuenModel.h
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/25.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndexHeardMuenModel : NSObject
+(IndexHeardMuenModel *) shareInstance;
/*区域*/
@property(nonatomic, strong)NSDictionary *area;
/*租金*/
@property(nonatomic, strong)NSDictionary *screen;
/*筛选*/
@property(nonatomic, strong)NSDictionary *rent;
/*排序*/
@property(nonatomic, strong)NSDictionary *sorting;


@end

NS_ASSUME_NONNULL_END
