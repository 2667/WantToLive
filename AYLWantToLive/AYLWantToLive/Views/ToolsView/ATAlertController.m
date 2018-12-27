//
//  ATAlertController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATAlertController.h"

@interface ATAlertController ()

@end

@implementation ATAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (ATAlertController *) alertWithTitle:(NSString *) title message:(NSString *) reminder {
    ATAlertController *alert = [ATAlertController alertControllerWithTitle:title message:reminder preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    
    return alert;
}

- (void) dissMissAlert {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:)userInfo:self repeats:NO];
}
- (void)timerAction:(NSTimer*)timer
{
    UIAlertController * alert = (UIAlertController *)[timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    
    alert = nil;
}

@end
