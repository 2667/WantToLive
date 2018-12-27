//
//  ATMyHeadModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/11.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface ATMyHeadModel : NSObject

@property(nonatomic) NSString *userId;
@property(nonatomic) NSString *nickName;
@property(nonatomic) NSString *phoneNumber;
@property(nonatomic) NSString *password;
@property(nonatomic) NSString *sex;
@property(nonatomic) NSString *avatarPath;

@end
