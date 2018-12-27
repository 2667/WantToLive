//
//  AYLDetailViewController.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/26.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "AYLDetailViewController.h"

#import "RoomInfo.h"

@interface AYLDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isCollect;
}

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *image;
@property(nonatomic, assign) CGFloat offset;
@property(nonatomic, strong) CHCycleScrollView *scrollView;
@property(nonatomic, strong) UIView *suspensionView;
@property(nonatomic, strong) UIButton *collect;
@property(nonatomic, strong) UIButton *reservation;
@property(nonatomic, strong) UIButton *phoneConsult;


@end

@implementation AYLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
