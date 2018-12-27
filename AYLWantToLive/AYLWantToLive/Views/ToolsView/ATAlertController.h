//
//  ATAlertController.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATAlertController : UIAlertController

//错误提示
+ (ATAlertController *) alertWithTitle:(NSString *) title message:(NSString *) reminder;

- (void) dissMissAlert;

@end
