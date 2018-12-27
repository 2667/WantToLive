//
//  ATMyHeadModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/11.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATMyHeadModel.h"

@implementation ATMyHeadModel

- (NSString *)userId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@"userId"];
    if (userId == nil || userId.length == 0) {
        return @"";
    }
    return userId;
}
- (void)setUserId:(NSString *)userId {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userId forKey:@"userId"];
    [userDefaults synchronize];
}


- (NSString *)nickName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *nickName = [userDefaults objectForKey:@"nickName"];
    if (nickName == nil || nickName.length == 0) {
        return @"";
    }
    return nickName;
}
- (void)setNickName:(NSString *)nickName {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nickName forKey:@"nickName"];
    [userDefaults synchronize];
}

- (NSString *)phoneNumber {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *phoneNumber = [userDefaults objectForKey:@"phoneNumber"];
    if (phoneNumber == nil || phoneNumber.length == 0) {
        return @"";
    }
    return phoneNumber;
}
- (void)setPhoneNumber:(NSString *)phoneNumber {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phoneNumber forKey:@"phoneNumber"];
    [userDefaults synchronize];
}

- (NSString *)password {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *password = [userDefaults objectForKey:@"password"];
    if (password == nil || password.length == 0) {
        return @"";
    }
    return password;
}
- (void)setPassword:(NSString *)password {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
}

- (NSString *)sex {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sex = [userDefaults objectForKey:@"sex"];
    if (sex == nil || sex.length == 0) {
        return @"";
    }
    return sex;
}
- (void)setSex:(NSString *)sex {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:sex forKey:@"sex"];
    [userDefaults synchronize];
}

//- (NSString *)avatarPath {
//
//}
//- (void)setAvatarPath:(NSString *)avatarPath {
//
//}

WZLSERIALIZE_CODER_DECODER()

@end
