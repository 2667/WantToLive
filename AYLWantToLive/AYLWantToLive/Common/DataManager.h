//
//  DataManager.h
//  AYLWeather
//
//  Created by AYLiOS on 2018/11/28.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockDefine.h"

@interface DataManager : NSObject

+(DataManager *) shareInstance;

-(void)getAllRoomList:(NSDictionary *)parameters callback:(NSArrayCallBack)call;


-(void)getRoomInfo:(NSDictionary *)parameters callback:(NSObjectCallBack)call;

@end
