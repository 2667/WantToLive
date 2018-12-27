//
//  DBManager.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/11.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "RoomInfo.h"

@interface DBManager ()

@property(nonatomic, copy)NSString * dbPath;

@end

@implementation DBManager

static DBManager *_instance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil)
            _instance = [[DBManager alloc] init];
    });
    return _instance;
}

-(void)clearAllForTable:(NSString *)tableName{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",tableName];
        [db executeUpdate:sql];
        [db close];
    }
}

-(void)createTableSqlString:(NSArray *)sqlStrings tableNames:(NSArray <NSString *>*)tableNames{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.dbPath = [doc stringByAppendingPathComponent:@"User.sqlite"];
    
    NSLog(@"self.dbPath : %@", self.dbPath);
    
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            for (NSString *sql in sqlStrings) {
                BOOL res = [db executeUpdate:sql];
                if (res == NO) {
                    NSLog(@"创建数据表成功");
                }
            }
            [db close];
        } else {
            NSLog(@"创建数据库失败");
        }
    }else{
        //检查数据库有是否有想要创建的数据表
        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            int i = 0;
            for (NSString *tableName in tableNames) {
                NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName ];
                FMResultSet *rs = [db executeQuery:existsSql];
                if ([rs next]) {
                    NSInteger count = [rs intForColumn:@"countNum"];
                    if (count == 1) {
                        NSLog(@"存在");
                    }else{
                        NSString *sql = sqlStrings[i];
                        BOOL res = [db executeUpdate:sql];
                        if (res == NO) {
                            NSLog(@"创建数据表成功");
                        }
                    }
                }
                i++;
            }
            [db close];
        }
    }
}

-(void)insertData:(id)data table:(NSString *)tableName columns:(NSString *)column{
        RoomInfo *info = (RoomInfo *)data;
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ", tableName, column];
          
            NSString *area_name = info.area_name;
            NSString *pic_main= info.pic_main;
            NSString *hire_way= info.hire_way;
            NSString *is_charter= info.is_charter;
            NSString *latlon= info.latlon;
            NSString *bathroom= info.bathroom;
            NSString *subdistrict_id= info.subdistrict_id;
            NSString *room_direction= info.room_direction;
            NSString *virtualNumber= info.virtualNumber;
            NSString *rent_area= info.rent_area;
            NSString *livingroom= info.livingroom;
            NSString *subdistrict_name= info.subdistrict_name;
            NSString *house_source= info.house_source;
            NSString *floor_area= info.floor_area;
            NSString *subway_desc= info.subway_desc;
            NSString *bedroom= info.bedroom;
            NSString *is_monthly_pay= info.is_monthly_pay;
            NSString *house_main_image= info.house_main_image;
            NSString *month_rent= info.month_rent;
            NSString *room_type= info.room_type;
            NSString *house_info_concat= info.house_info_concat;
            NSString *house_info_concat_two= info.house_info_concat_two;
            NSString *no_renter_commission= info.no_renter_commission;
            NSString *publish_date= info.publish_date;
            NSString *house_id= info.house_id;
            NSString *is_discount= info.is_discount;
            NSString *subway_line= info.subway_line;
            NSString *search_subway= info.search_subway;
            NSString *search_subway_distance= info.search_subway_distance;
            NSString *is_collect= info.is_collect;
            NSString *private_bathroom= info.private_bathroom;
            
            NSString *nshelves= info.nshelves;
            NSString *comprehensive_score= info.comprehensive_score;
            NSString *rank_weight= info.rank_weight;
            NSString *is_topic= info.is_topic;
            NSString *is_proxy_served= info.is_proxy_served;
            NSString *is_true_photo= info.is_true_photo;
            NSString *house_photo_num= info.house_photo_num;
            NSString *fangdong_say= info.fangdong_say;
          NSString *is_qiye_fangdong= info.is_qiye_fangdong;
            NSString *is_tu_plus= info.is_tu_plus;
            NSString *is_open_fee= info.is_open_fee;
            NSString *only_one_price= info.only_one_price;
            NSString *house_now_status= info.house_now_status;
            NSString *authState= info.authState;
            NSString *agency_type= info.agency_type;
            NSString *has_shop= info.has_shop;
            NSString *lanPortrait= info.lanPortrait;
            NSString *lanName= info.lanName;
            NSString *lanNum= info.lanNum;
            NSString *lanLable= info.lanLable;
            NSString *look_any= info.look_any;
            NSString *has_juzhu= info.has_juzhu;
            NSString *side_desc= info.side_desc;
            NSString *co_id= info.co_id;
            NSString *labels =[info.labels componentsJoinedByString:@","];;
     
            [db executeUpdate:sql, area_name,pic_main,hire_way,is_charter,latlon,bathroom,subdistrict_id,room_direction,virtualNumber,rent_area,livingroom,subdistrict_name,house_source,floor_area,subway_desc,bedroom,is_monthly_pay,house_main_image,month_rent,room_type,house_info_concat,house_info_concat_two,no_renter_commission,publish_date,house_id,is_discount,subway_line,search_subway,search_subway_distance,is_collect,private_bathroom,labels,nshelves,comprehensive_score,rank_weight,is_topic,is_proxy_served,is_true_photo,house_photo_num,fangdong_say,is_qiye_fangdong,is_tu_plus,is_open_fee,only_one_price,house_now_status,authState,agency_type,has_shop,lanPortrait,lanName,lanNum,lanLable,look_any,has_juzhu,side_desc,co_id];
            [db close];
        }
}

-(void)update:(NSString *)conditions newValues:(NSString *)value cums:(NSString *)cums  table:(NSString *)tableName{
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        
        NSString * sql;
        if (conditions == nil) {
            sql = [NSString stringWithFormat:@"UPDATE %@ SET %@", tableName, cums];
        }else{
            sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@", tableName, cums, conditions];
        }
        
        [db executeUpdate:sql];
        [db close];
    }
}

-(NSArray *)queryData:(NSString *)conditions table:(NSString *)tableName{
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    NSMutableArray *resultsArray = [NSMutableArray array];
    if ([db open]) {
        NSString *sql;
        if (conditions == nil) {
            sql = [NSString stringWithFormat:@"select * from %@",tableName];
        }else{
            sql = [NSString stringWithFormat:@"select * from %@ where  %@",tableName, conditions];
        }
        
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            if ([tableName isEqualToString:@"roomInfo"] == YES) {
               RoomInfo *info = [[RoomInfo alloc]init];
                
                
                info.area_name = [rs stringForColumn:@"area_name"];
                info.pic_main = [rs stringForColumn:@"pic_main"];
                info.hire_way = [rs stringForColumn:@"hire_way"];
                info.is_charter = [rs stringForColumn:@"is_charter"];
                info.latlon = [rs stringForColumn:@"latlon"];
                info.bathroom = [rs stringForColumn:@"bathroom"];
                info.subdistrict_id = [rs stringForColumn:@"subdistrict_id"];
                info.room_direction = [rs stringForColumn:@"room_direction"];
                info.virtualNumber = [rs stringForColumn:@"virtualNumber"];
                info.rent_area = [rs stringForColumn:@"rent_area"];
                info.livingroom = [rs stringForColumn:@"livingroom"];
                info.subdistrict_name = [rs stringForColumn:@"subdistrict_name"];
                info.house_source = [rs stringForColumn:@"house_source"];
                info.floor_area = [rs stringForColumn:@"floor_area"];
                info.subway_desc = [rs stringForColumn:@"subway_desc"];
                info.bedroom = [rs stringForColumn:@"bedroom"];
                info.is_monthly_pay = [rs stringForColumn:@"is_monthly_pay"];
                info.house_main_image = [rs stringForColumn:@"house_main_image"];
                info.month_rent = [rs stringForColumn:@"month_rent"];
                info.room_type = [rs stringForColumn:@"room_type"];
                info.house_info_concat = [rs stringForColumn:@"house_info_concat"];
                info.house_info_concat_two = [rs stringForColumn:@"house_info_concat_two"];
                info.no_renter_commission = [rs stringForColumn:@"no_renter_commission"];
                info.publish_date = [rs stringForColumn:@"publish_date"];
                info.house_id = [rs stringForColumn:@"house_id"];
                info.is_discount = [rs stringForColumn:@"is_discount"];
                info.subway_line = [rs stringForColumn:@"subway_line"];
                info.search_subway = [rs stringForColumn:@"search_subway"];
                info.search_subway_distance = [rs stringForColumn:@"search_subway_distance"];
                info.is_collect = [rs stringForColumn:@"is_collect"];
                info.private_bathroom = [rs stringForColumn:@"private_bathroom"];
                info.nshelves = [rs stringForColumn:@"nshelves"];
                info.comprehensive_score = [rs stringForColumn:@"comprehensive_score"];
                info.rank_weight = [rs stringForColumn:@"rank_weight"];
                info.is_topic = [rs stringForColumn:@"is_topic"];
                info.is_proxy_served = [rs stringForColumn:@"is_proxy_served"];
                info.is_true_photo = [rs stringForColumn:@"is_true_photo"];
                info.house_photo_num = [rs stringForColumn:@"house_photo_num"];
                info.fangdong_say = [rs stringForColumn:@"fangdong_say"];
                info.is_qiye_fangdong = [rs stringForColumn:@"is_qiye_fangdong"];
                info.is_tu_plus = [rs stringForColumn:@"is_tu_plus"];
                info.is_open_fee = [rs stringForColumn:@"is_open_fee"];
                info.only_one_price = [rs stringForColumn:@"only_one_price"];
                info.house_now_status = [rs stringForColumn:@"house_now_status"];
                info.authState = [rs stringForColumn:@"authState"];
                info.agency_type = [rs stringForColumn:@"agency_type"];
                info.has_shop = [rs stringForColumn:@"has_shop"];
                info.lanPortrait = [rs stringForColumn:@"lanPortrait"];
                info.lanName = [rs stringForColumn:@"lanName"];
                info.lanNum = [rs stringForColumn:@"lanNum"];
                info.lanLable = [rs stringForColumn:@"lanLable"];
                info.look_any = [rs stringForColumn:@"look_any"];
                info.has_juzhu = [rs stringForColumn:@"has_juzhu"];
                info.side_desc = [rs stringForColumn:@"side_desc"];
                info.co_id = [rs stringForColumn:@"co_id"]; 
                [resultsArray addObject:info];
            }
            
        }
        [db close];
    }
    return resultsArray;
}

@end
