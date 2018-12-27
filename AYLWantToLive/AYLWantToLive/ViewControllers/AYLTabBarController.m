//
//  AYLTabBarController.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/19.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "AYLTabBarController.h"
#import "AYLBaseViewController.h"

#import "AYLIndexViewController.h"
#import "AYLFavoriteViewController.h"
#import "AYLMyViewController.h"

@interface AYLTabBarController ()

@end

@implementation AYLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UITabBar appearance].translucent = NO;
    self.tabBar.tintColor = [UIColor blackColor];
    
    UINavigationController *indexNav = [self p_SetTabBarItem:[[AYLIndexViewController alloc]init] withViewControllerTitle:@"房源" image:[UIImage imageNamed:@"home_normal"] selectImage:[UIImage imageNamed:@"home_highlight"]];
    
    UINavigationController *favoriteNav = [self p_SetTabBarItem:[[AYLFavoriteViewController alloc]init] withViewControllerTitle:@"收藏" image:[UIImage imageNamed:@"message_normal"] selectImage:[UIImage imageNamed:@"message_highlight"]];
    
    UINavigationController *myNav = [self p_SetTabBarItem:[[AYLMyViewController alloc]init] withViewControllerTitle:@"我的" image:[UIImage imageNamed:@"account_normal"] selectImage:[UIImage imageNamed:@"account_highlight"]];
    
    self.viewControllers = @[indexNav, favoriteNav, myNav];
    
}

#pragma mark - private

-(UINavigationController *)p_SetTabBarItem:(AYLBaseViewController *)vc withViewControllerTitle:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage{
    
    [vc setTitle:title];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [selectImage  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectImage];
    
    
    nav.tabBarItem = tabBarItem;
    
    return nav;
    
}



@end
