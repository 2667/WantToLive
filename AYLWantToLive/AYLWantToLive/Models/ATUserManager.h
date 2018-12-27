//
//  ATUserManager.h
//  AnnTenants
//
//  Created by HuangGang on 2018/3/26.
//  Copyright © 2018年 Harely. All rights reserved.
//
//NSUserDefaults的使用：https://www.jianshu.com/p/325e6bd028af

#import <Foundation/Foundation.h>

@interface ATUserManager : NSObject<NSCoding>

@property(nonatomic) BOOL isCreateUserTable;
@property(nonatomic, strong) NSMutableDictionary *user;
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *nickName;
@property(nonatomic, copy) NSString *phoneNumber;
@property(nonatomic, copy) NSString *password;
@property(nonatomic) NSUInteger sex;
@property(nonatomic, copy) NSString *avatarPath;

//获取单例类
+  (instancetype)shareUser;
- (void) setUserManagerDefaultValue;
+ (NSString *)filePath;
+ (void) deleteAllUserInformation;


@end
