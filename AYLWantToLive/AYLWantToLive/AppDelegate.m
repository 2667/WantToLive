//
//  AppDelegate.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/19.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "AppDelegate.h"

#import "AYLTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    
    
    // 创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置Window的背景颜色
    self.window.backgroundColor = [UIColor whiteColor];
    // 设置根控制器
    AYLTabBarController *vc = [[AYLTabBarController alloc] init];
    self.window.rootViewController = vc;
    // 设置并显示主窗口
    [self.window makeKeyAndVisible];
    
    [self initData];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"AYLWantToLive"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



-(void)initData{
    /*  创建数据库 */
    [[DBManager shareInstance]createTableSqlString:@[
                                                     @"\
                                                     CREATE TABLE roomInfo('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
                                                     'area_name' VARCHAR(255),\
                                                     'pic_main' VARCHAR(255),\
                                                     'hire_way' VARCHAR(255),\
                                                     'is_charter' VARCHAR(255),\
                                                     'latlon' VARCHAR(255),\
                                                     'bathroom' VARCHAR(255),\
                                                     'subdistrict_id' VARCHAR(255),\
                                                     'room_direction' VARCHAR(255),\
                                                     'virtualNumber' VARCHAR(255),\
                                                     'rent_area'  VARCHAR(255),\
                                                     'livingroom' VARCHAR(255),\
                                                     'subdistrict_name' VARCHAR(255),\
                                                     'house_source' VARCHAR(255),\
                                                     'floor_area' VARCHAR(255),\
                                                     'subway_desc' VARCHAR(255),\
                                                     'bedroom' VARCHAR(255),\
                                                     'is_monthly_pay'  VARCHAR(255),\
                                                     'house_main_image' VARCHAR(255),\
                                                     'month_rent'  VARCHAR(255),\
                                                     'room_type'  VARCHAR(255),\
                                                     'house_info_concat'  VARCHAR(255),\
                                                     'house_info_concat_two'  VARCHAR(255),\
                                                     'no_renter_commission'  VARCHAR(255),\
                                                     'publish_date'  VARCHAR(255),\
                                                     'house_id'  VARCHAR(255),\
                                                     'is_discount'  VARCHAR(255),\
                                                     'subway_line'  VARCHAR(255),\
                                                     'search_subway'  VARCHAR(255),\
                                                     'search_subway_distance'  VARCHAR(255),\
                                                     'is_collect'  VARCHAR(255),\
                                                     'private_bathroom'  VARCHAR(255),\
                                                     'labels'  VARCHAR(255),\
                                                     'nshelves'  VARCHAR(255),\
                                                     'comprehensive_score'  VARCHAR(255),\
                                                     'rank_weight'  VARCHAR(255),\
                                                     'is_topic'  VARCHAR(255),\
                                                     'is_proxy_served'  VARCHAR(255),\
                                                     'is_true_photo'  VARCHAR(255),\
                                                     'house_photo_num'  VARCHAR(255),\
                                                     'fangdong_say'  VARCHAR(255),\
                                                     'is_qiye_fangdong'  VARCHAR(255),\
                                                     'is_tu_plus'  VARCHAR(255),\
                                                     'is_open_fee'  VARCHAR(255),\
                                                     'only_one_price'  VARCHAR(255),\
                                                     'house_now_status'  VARCHAR(255),\
                                                     'authState'  VARCHAR(255),\
                                                     'agency_type'  VARCHAR(255),\
                                                     'has_shop'  VARCHAR(255),\
                                                     'lanPortrait'  VARCHAR(255),\
                                                     'lanName'  VARCHAR(255),\
                                                     'lanNum'  VARCHAR(255),\
                                                     'lanLable'  VARCHAR(255),\
                                                     'look_any'  VARCHAR(255),\
                                                     'has_juzhu'  VARCHAR(255),\
                                                     'side_desc'  VARCHAR(255),\
                                                     'co_id'  VARCHAR(255));"
                                                     ] tableNames:@[@"roomInfo"]];
}

@end
