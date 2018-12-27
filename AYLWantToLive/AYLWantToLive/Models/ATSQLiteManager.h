//
//  ATSQLiteManager.h
//  AnnTenants
//
//  Created by HuangGang on 2018/3/21.
//  Copyright © 2018年 Harely. All rights reserved.
//
//文件存储 ：https://www.jianshu.com/p/a620b8ae7ab7
//枚举：https://www.jianshu.com/p/30f76a950604

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class ATShareHouseJsonModel, ATCollectModel, ATReservationModel, ATInformationModel;

/**
 NS_ENUM定义通用枚举，NS_OPTIONS定义位移枚举
 _type：枚举类型变量值的格式
 _name：枚举类型的名字
 new：枚举类型的变量值列表
 */
#pragma mark - SQLite 表类型
typedef NS_ENUM(NSInteger, SQLiteTableType) {
    SQLiteTableTypeUser = 0,    //值为0
    SQLiteTableTypeHouse = 1,
    SQLiteTableTypeCollect =2,
    SQLiteTableTypeReservation =3,
    SQLiteTableTypeMessage = 4,
    SQLiteTableTypeOther        //值为2
};

@interface ATSQLiteManager : NSObject

//获得实例对象
+ (instancetype) sharedInstance;
//获取数据库地址
+ (sqlite3 *)gainDb;

//创建表单
+ (BOOL)isCreateTableWithType:(SQLiteTableType)sqliteTableType;
//注册插入数据
+ (BOOL) isInsertDataForRegister:(NSDictionary *)dictionary;
//发布房源数据插入
+ (BOOL) isInsertDataForHouseResource:(ATShareHouseJsonModel *) shareHouseJsonM;
//收藏数据插入
+ (BOOL) isInsertDataForCollectResource:(ATCollectModel *)collectM;
//预约数据插入
+ (BOOL) isInsertDataForReservation:(ATReservationModel *) reservationM;
//资讯数据插入
+ (BOOL) isInsertDataForMessage:(ATInformationModel *) informationM;
//关闭数据库
+(void) closeDatabase;
//开启数据库
+ (void) openDatabase;

@end
