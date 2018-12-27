//
//  DataManager.m
//  AYLWeather
//
//  Created by AYLiOS on 2018/11/28.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "DataManager.h"

#import "RoomInfo.h"

@implementation DataManager

static DataManager *_instance;

+(DataManager*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil)
            _instance = [[DataManager alloc] init];
    });
    return _instance;
}


-(void)getAllRoomList:(NSDictionary *)parameters callback:(NSArrayCallBack)call{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSURLSessionDataTask *task = [manager POST:ADD(ALLROOMLIST) parameters:param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataViewModelList = [RoomInfo mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        call(dataViewModelList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@" error >> %@", error);
    }];
    [task resume];
}




-(void)getRoomInfo:(NSDictionary *)parameters callback:(NSObjectCallBack)call{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSURLSessionDataTask *task = [manager POST:ADD(APARTMENTHOUSESSHOWS) parameters:param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject : %@", responseObject);
        
        RoomInfo *model = [RoomInfo mj_objectWithKeyValues:responseObject[@"result"]];

        call(model);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@" error >> %@", error);
    }];
    [task resume];
}

@end
