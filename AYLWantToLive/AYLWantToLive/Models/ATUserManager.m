//
//  ATUserManager.m
//  AnnTenants
//
//  Created by HuangGang on 2018/3/26.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATUserManager.h"

@implementation ATUserManager

static  ATUserManager *_instance = nil;

//每次程序一启动,就会把所有的类加载进内存，这里模拟苹果做的，但是如果把这段代码解开会造成崩溃
//+ (void) load {
//    ATLog(@"%s", __func__);
//    _instance = [[self alloc] init];
//}

+  (instancetype)shareUser {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}


+ (instancetype) alloc  {
    if (_instance) {
//        标示已经分配好了,就不允许外界在分配内存
        
        /**
         创建异常类
         @name 异常的名称
         @reson 异常的原因
         @userInfo 异常的信息
         */
        NSException *excp = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one Person instance." userInfo:nil];
        
//        抛异常
        [excp raise];
    }
    
//    super -> NSObject 才知道怎么分配内存
//    调用系统默认的做法, 当重写一个方法的时候,如果不想要覆盖原来的实现,就调用super
    return  [super alloc];
}

//写入是否创建了User的Sqlite表
- (BOOL)isCreateUserTable{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *isUser = [userDefaults objectForKey:@"isCreateUserTable"];
    
    return [isUser boolValue];
}
//读取数据
- (void)setIsCreateUserTable:(BOOL)isCreateUserTable {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(isCreateUserTable) forKey:@"isCreateUserTable"];
    
    [userDefaults synchronize];
}

- (void)setUserId:(NSString *)userId {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userId forKey:@"userId"];
    [userDefaults synchronize];
}
- (NSString *)userId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@"userId"];
    if (userId == nil || userId.length == 0) {
        return @"";
    }
    return userId;
}

- (void)setNickName:(NSString *)nickName {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nickName forKey:@"nickName"];
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

- (void)setPhoneNumber:(NSString *)phoneNumber {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phoneNumber forKey:@"phoneNumber"];
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

- (void)setPassword:(NSString *)password {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
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

- (void)setSex:(NSUInteger)sex {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(sex) forKey:@"sex"];
    [userDefaults synchronize];
}
- (NSUInteger)sex {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *sex = [userDefaults objectForKey:@"sex"];
    
    return sex.integerValue;
}


//NSUserDefaults 设置默认值,不会覆盖用户设置的值，放在 applicationDidFinishLaunching
- (void) setUserManagerDefaultValue {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{@"isCreateUserTable": @FALSE}];
    [userDefaults synchronize];
}

//删除NSUserDefaults所有记录
+ (void) deleteAllUserInformation {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [userDefaults dictionaryRepresentation];
    for (id key in dict) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}


#pragma mark - 运行时宏定义编码和解码
WZLSERIALIZE_CODER_DECODER()
+ (NSString *)filePath
{
    NSString *archiverFilePath = nil;
//    应用程序目录的路径，在该目录下有三个文件夹：Documents、Library、temp和一个.app的包,该目录下就是应用程序的沙盒
    if (TARGET_IPHONE_SIMULATOR) {
       archiverFilePath = [NSString stringWithFormat:@"%@/archiver", NSHomeDirectory()];
    }else {
        archiverFilePath = [ATDocumentPath stringByAppendingPathComponent:@"/archiver"];
    }

    return archiverFilePath;
}

@end
