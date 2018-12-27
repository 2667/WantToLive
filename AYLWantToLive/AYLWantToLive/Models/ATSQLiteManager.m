//
//  ATSQLiteManager.m
//  AnnTenants
//
//  Created by HuangGang on 2018/3/21.
//  Copyright © 2018年 Harely. All rights reserved.
//http://snowolf.iteye.com/blog/1568926

#import "ATSQLiteManager.h"


//私有全局变量
static ATSQLiteManager *instance = nil;
//能保证_db这个变量只被ATSQLiteManager直接访问
static sqlite3 *_db;

//sql语句
//图片无法直接存入数据库中需要把图片转换为二进制后存入数据库,二进制存储的格式为 blob
static NSString *const userTable = @"create table if not exists user (userId text primary key not null, nickName text not null, phoneNumber text not null, password text not null, sex int, avatarPath text);";

//房源语句
static NSString *const  housingResource = @"create table if not exists housingResource(houseResourceID text primary key not null, userId text not null, rentType text not null, housePicturesPath text not null, location text not null, floor text not null, houseType text not null, orientation text not null, decorated text not null, area text not null, houseConfiguration text not null, rent text not null, paymentWays text not null, onHireDuration text not null, renterRequire text, detailDescribe text, publishTime text not null)";

//收藏房源
static NSString *const collectHouseResource = @"create table if not exists collectHouseResource(userId text not null, houseResourceID text primary key not null, isCollect text not null)";

//预约房源
static NSString *const reservationHouseResource = @"create table if not exists reservationHouseResource(userId text not null, houseResourceID text primary key not null, reservationTime text not null, isReservation text not null)";

//资讯
static NSString *const message = @"create table if not exists message(informationID text primary key not null, imageName text not null, mainTitle text not null, abstract text not null, url text not null)";


@implementation ATSQLiteManager

+ (instancetype) sharedInstance {
//只进行一次
    static dispatch_once_t onceToken;
//第一个参数是检查后面第二个参数所代表的代码块是否被调用的谓词,第二个参数则是在整个应用程序中只会被调用一次的代码块。dispach_once函数中的代码块只会被执行一次，而且还是线程安全的。
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        /* 基础属性值都写在这里： instance.height = 10; ......*/
    });
    return  instance;
}

//重写+allocWithZone方法，保证永远都只为单例对象分配一次内存空间
+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}


//创建表
+ (BOOL)isCreateTableWithType:(SQLiteTableType)sqliteTableType  {
    BOOL isDatabase = [ATSQLiteManager isOpenDatabaseForSqliteDocument];
    BOOL isCreateSuccess = FALSE;
    
    if (isDatabase) {
        switch (sqliteTableType) {
            case SQLiteTableTypeUser:
                if ([ATSQLiteManager createUserTable:userTable]) {
                    isCreateSuccess = YES;
                    ATUserManager.shareUser.isCreateUserTable = YES;
                    [ATSQLiteManager closeDatabase];
                }else {
                    ATLog(@"user 建表失败");
                }
                break;
            case SQLiteTableTypeHouse:{
                if ([ATSQLiteManager createUserTable:housingResource]) {
                    [ATSQLiteManager closeDatabase];
                }else {
                    ATLog(@"housingResource 建表失败");
                }
                break;
            }
           case SQLiteTableTypeCollect: {
               if ([ATSQLiteManager createUserTable:collectHouseResource]) {
                   [ATSQLiteManager closeDatabase];
               }else {
                   ATLog(@"collectHouseResource 建表失败");
               }
               break;
            }
           case SQLiteTableTypeReservation:{
               if ([ATSQLiteManager createUserTable:reservationHouseResource]) {
                   [ATSQLiteManager closeDatabase];
               }else {
                   ATLog(@"reservationHouseResource 建表失败");
               }
               break;
            }
            case SQLiteTableTypeMessage:{
                if ([ATSQLiteManager createUserTable:message]) {
                    [ATSQLiteManager closeDatabase];
                }else {
                    ATLog(@"message 建表失败");
                }
                break;
            }
            default:
                break;
        }
    }else {
        ATLog(@"建库失败！");
    }
    
    return isCreateSuccess;
}


+ (BOOL) isInsertDataForRegister:(NSDictionary *)dictionary {
    char *errorMesg = NULL;
    if ([ATSQLiteManager isOpenDatabaseForSqliteDocument]) {
        NSString *sql = [NSString stringWithFormat:@"insert into user (userId, nickName, phoneNumber, password, sex, avatarPath) values('%@', '%@', '%@', '%@', '%@', '%@');", dictionary[@"userId"], dictionary[@"nickName"], dictionary[@"phoneNumber"], dictionary[@"password"], dictionary[@"sex"], dictionary[@"avatarPath"]];
        int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMesg);
        
//        销毁指针
        sqlite3_free(errorMesg);
        [ATSQLiteManager closeDatabase];
        
        return result == SQLITE_OK;
    }else {
        ATLog(@"注册User表插入数据失败:%s", errorMesg);
        return  FALSE;
    }
    
}

+ (BOOL) isInsertDataForHouseResource:(ATShareHouseJsonModel *) shareHouseJsonM {
    [ATSQLiteManager isOpenDatabaseForSqliteDocument];
    
    sqlite3_stmt *statement;
    
    static char *sql = "insert into housingResource(houseResourceID, userId, rentType, housePicturesPath, location, floor, houseType, orientation, decorated, area, houseConfiguration, rent, paymentWays, onHireDuration, renterRequire, detailDescribe, publishTime) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    int success2 = sqlite3_prepare_v2(_db, sql, -1, &statement, NULL);
    if (success2 != SQLITE_OK) {
        ATLog(@"housingResource 插入数据失败");
        [ATSQLiteManager closeDatabase];
        return  NO;
    }
    
//    绑定数据
//    -1:为字符串长度; SQLITE_TRANSIENT:为一个函数指针,SQLITE3执行完操作后回调此函数，通常用于释放字符串占用的内存。SQLITE_STATIC告诉sqlite3_bind_text函数字符串为常量，可以放心使用；而SQLITE_TRANSIENT会使得sqlite3_bind_text函数对字符串做一份拷贝。
//    数字1，2，3代表上面的第几个问号，这里将三个值绑定到三个绑定变量
//    sqlite3_bind_text(statement, 1, [shareHouseJsonM.houseingResourceID UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 2, [shareHouseJsonM.userId UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 3, [shareHouseJsonM.rentType UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 4, [shareHouseJsonM.housePicturesPath UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 5, [shareHouseJsonM.location UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 6, [shareHouseJsonM.floor UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 7, [shareHouseJsonM.houseType UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 8, [shareHouseJsonM.orientation UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 9, [shareHouseJsonM.decorated UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 10, [shareHouseJsonM.area UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 11, [shareHouseJsonM.houseConfiguration UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 12, [shareHouseJsonM.rent UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 13, [shareHouseJsonM.paymentWays UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 14, [shareHouseJsonM.onHireDuration UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 15, [shareHouseJsonM.renterRequire UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 16, [shareHouseJsonM.detailDescribe UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 17, [shareHouseJsonM.publishTime UTF8String], -1, SQLITE_TRANSIENT);
    
//    执行插入语句
    success2 = sqlite3_step(statement);
//    释放statement
    sqlite3_finalize(statement);
    
    if (success2 == SQLITE_ERROR) {
        ATLog(@"housingResource 插入数据失败");
        [ATSQLiteManager closeDatabase];
        return  NO;
    }
    [ATSQLiteManager closeDatabase];
    return YES;
}


+ (BOOL) isInsertDataForCollectResource:(ATCollectModel *)collectM {
    [ATSQLiteManager isOpenDatabaseForSqliteDocument];
    
    char *errorMesg = NULL;
//    NSString *sql = [NSString stringWithFormat:@"insert into collectHouseResource (userId, houseResourceID, isCollect) values('%@', '%@', '%@');", collectM.userId, collectM.houseResourceID, collectM.isCollect];
//    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMesg);
    
    //        销毁指针
//    sqlite3_free(errorMesg);
//    [ATSQLiteManager closeDatabase];
    
//    if(result == SQLITE_OK) {
//        return YES;
//    }else {
//        ATLog(@"collectHourceResource表插入数据失败:%s", errorMesg);
        return  FALSE;
//    }
}

+ (BOOL) isInsertDataForReservation:(ATReservationModel *) reservationM {
    [ATSQLiteManager isOpenDatabaseForSqliteDocument];
    
//    char *errorMesg = NULL;
//    NSString *sql = [NSString stringWithFormat:@"insert into reservationHouseResource (userId, houseResourceID, reservationTime, isReservation) values('%@', '%@', '%@', '%@');", reservationM.userId, reservationM.houseResourcID, reservationM.reservationTime, reservationM.isReservation];
//    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMesg);
//
//    //        销毁指针
//    sqlite3_free(errorMesg);
//    [ATSQLiteManager closeDatabase];
//
//    if(result == SQLITE_OK) {
//        return YES;
//    }else {
//        ATLog(@"reservationHouseResource 表插入数据失败:%s", errorMesg);
        return  FALSE;
//    }
}

+ (BOOL) isInsertDataForMessage:(ATInformationModel *) informationM {
//    [ATSQLiteManager isOpenDatabaseForSqliteDocument];
//
//    char *errorMesg = NULL;
//    NSString *sql = [NSString stringWithFormat:@"insert into message (informationID, imageName, mainTitle, abstract, url) values('%@', '%@', '%@', '%@', '%@');", informationM.informationID, informationM.imageName, informationM.mainTitle, informationM.abstract, informationM.url];
//    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMesg);
//
//    //        销毁指针
//    sqlite3_free(errorMesg);
//    [ATSQLiteManager closeDatabase];
//
//    if(result == SQLITE_OK) {
//        return YES;
//    }else {
//        ATLog(@"message 表插入数据失败:%s", errorMesg);
        return  FALSE;
//    }
}

+ (BOOL)createUserTable:(NSString *) createTableSQLStatement {
    char *errorMesg = NULL;
    int result = sqlite3_exec(_db, createTableSQLStatement.UTF8String, NULL, NULL, &errorMesg);
    return  result == SQLITE_OK;
}


#pragma mark - 关闭或者开启数据库
+ (void) openDatabase {
    if (![ATSQLiteManager isOpenDatabaseForSqliteDocument]) {
        [ATSQLiteManager isOpenDatabaseForSqliteDocument];
    }else {
        return;
    }
}

+(void)closeDatabase{
    
    int result = sqlite3_close(_db) ;
    
    [ATSQLiteManager judgeWithResult:result action:@"关闭数据库"];
//    pthread_mutex_unlock(&mutex);   //多线程中对数据库的操作
}

+ (bool)isOpenDatabaseForSqliteDocument {
//    pthread_mutex_lock(&mutex);
    //    获得沙盒中的数据库文件名
    NSString *fileName = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [fileName stringByAppendingPathComponent: @"AnnTenants.sqlite"];
    NSLog(@"数据库路径:%@", filePath);
    
    //    创建(打开)数据库（如果数据库文件不存在，会自动创建）
    int result = sqlite3_open(filePath.UTF8String, &_db);
    return result == SQLITE_OK;
}

+ (void)judgeWithResult:(int)result action:(NSString *)actionStr{
    
    if (result == SQLITE_OK) {
        NSLog(@"%@成功",actionStr);
    }
    else
    {
        ATLog(@"%@失败",actionStr);
    }
}

+ (sqlite3 *)gainDb {
    return  _db; 
}


@end
