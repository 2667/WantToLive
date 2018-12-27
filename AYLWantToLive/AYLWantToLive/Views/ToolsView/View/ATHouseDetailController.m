//
//  ATHouseDetailController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/29.
//  Copyright © 2018年 Harely. All rights reserved.
// contentInset, contetnSize, contentOffset:https://blog.csdn.net/jackshiny/article/details/51007311

#import "ATHouseDetailController.h"

#import "CLProgressHUD.h"

@interface ATHouseDetailController ()<UITableViewDelegate, UITableViewDataSource, CHCycleScrollViewDelegate>
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

@implementation ATHouseDetailController
static NSString *const reuseId = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ATRGBA(239, 239, 245, 1.0);
    
    _isCollect = NO;
    
//    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
//    self.image.image = self.shareHouseJsonModel.housePictures.firstObject;//[UIImage imageNamed:@"zhaoYunSkinOne.jpg"];
//    [self.view addSubview:self.image];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
//    设置单元格开始在tableView显示的位置
    self.tableView.contentInset = UIEdgeInsetsMake(self.view.frame.size.height/3 - 64, 0, 0, 0);
    [self.view addSubview: self.tableView];
    self.offset = self.tableView.contentOffset.y;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
    
    NSArray *pictures = @[[UIImage imageNamed:@"1d"], [UIImage imageNamed:@"2d"]];//@[NSArray arrayWithArray:self.shareHouseJsonModel.labels];
    self.scrollView = [[CHCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ATSCREEN_HEIGHT/3) imageGroups:pictures];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

-(void)cycleScrollView:(CHCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"index = %ld",index);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    添加悬浮视图
    [[[UIApplication sharedApplication].delegate window] addSubview:self.suspensionView];
    
//    隐藏tabBarController
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
     
                       forBarPosition:UIBarPositionAny
     
                           barMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
  
    [self.suspensionView removeFromSuperview];

}



#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellID = @"ATKeyInformationCellView";
        ATKeyInformationCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ATKeyInformationCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell bindModel:self.shareHouseJsonModel];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellID = @"ATRoomInfoCellView";
        ATRoomInfoCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ATRoomInfoCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell bindModel:self.shareHouseJsonModel];
        return cell;
    }else if (indexPath.section == 2) {
        static NSString *cellID = @"ATLocationCellView";
        ATLocationCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ATLocationCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell bindModel:self.shareHouseJsonModel];
        
        return cell;
    }else if (indexPath.section == 3) {
        static NSString *cellID = @"ATFacilityCellView";
        ATFacilityCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ATFacilityCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell bindModel:self.shareHouseJsonModel];
        
        return cell;
    }
    
    static NSString *cellID = @"ATDetailDescribeCellView";
    ATDetailDescribeCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ATDetailDescribeCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindModel:self.shareHouseJsonModel];
    
    return cell;
    
}

#pragma mark - UITableViewDeleagte
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 141;
    }else if(indexPath.section == 1) {
        return 155;
    }else if(indexPath.section == 2) {
        return 72;
    } else if (indexPath.section == 3) {
        NSArray *hc = self.shareHouseJsonModel.labels;//[self.shareHouseJsonModel.houseConfiguration componentsSeparatedByString:@","];
        return 64 + (hc.count/5 +1)*44;
    }else if (indexPath.section == 4) {
        return 150;
    }
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

#pragma mark ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%f---%f",y,self.offset);
    CGRect frame = self.scrollView.frame;
    if (y > self.offset) {
        NSLog(@"向上");
        self.title = @"";
        frame.origin.y = self.offset-y;
        if (y>=0) {
            frame.origin.y = self.offset;
            self.title = @"详情";
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        }
        self.scrollView.frame = frame;
    }
    // tableView设置偏移时不能立马获取他的偏移量，所以一开始获取的offset值为0
    else if (self.offset == 0) return;
    else {
        NSLog(@"向下");
        CGFloat x = self.offset - y;
        frame = CGRectMake(-x/2, -x/2, self.view.frame.size.width + x, self.view.frame.size.height/3+x);
//        self.scrollView.frame = frame;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
}

- (UIView *)suspensionView {
    if (!_suspensionView) {
        _suspensionView = [[UIView alloc] initWithFrame:CGRectMake(0, ATSCREEN_HEIGHT - 64, ATSCREEN_WIDTH, 64)];
        _suspensionView.backgroundColor = [UIColor whiteColor];
        UIView *viewOne = [[UIView alloc] initWithFrame:CGRectMake(79, 0, 1, 84)];
        viewOne.backgroundColor = ATRGBA(238, 238, 245, 1.0);
        UIView *viewTwo = [[UIView alloc] initWithFrame:CGRectMake(153, 0, 1, 64)];
        viewTwo.backgroundColor = ATRGBA(238, 238, 245, 1.0);
        
        [_suspensionView addSubview:viewOne];
        [_suspensionView addSubview:viewTwo];
        [_suspensionView addSubview:self.collect];
        [_suspensionView addSubview:self.reservation];
        [_suspensionView addSubview:self.phoneConsult];
        
    }
    return _suspensionView;
}

- (UIButton *)collect {
    if (!_collect) {
        CGRect frame = CGRectMake(10, 0, 64, 64);
        if (![ATTools isBlankString:ATUserManager.shareUser.userId]) { //判断用户是否注册或者登录
//            _isCollect = [ATHouseResourceViewModel isCollectHouseResourceForConditions:[NSString stringWithFormat:@"userId = '%@' and houseResourceID = '%@'", self.shareHouseJsonModel.userId, self.shareHouseJsonModel.houseingResourceID]];
            if (_isCollect) { //判断这个用户是否已经收藏这个房源了
                _collect = [self createButtonForFrame:frame withImage:@"collect1" title:@"已收藏"];
            } else {
                _collect = [self createButtonForFrame:frame withImage:@"unCollect1" title:@"收藏"];
            }
        }else {
            _collect = [self createButtonForFrame:frame withImage:@"unCollect1" title:@"收藏"];
        }
        [_collect addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collect;
}

- (UIButton *)reservation {
    if (!_reservation) {
        CGRect frame = CGRectMake(84, 0, 64, 64);
        _reservation = [self createButtonForFrame:frame withImage:@"unReservation" title:@"预约"];
        [_reservation addTarget:self action:@selector(reservationAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reservation;
}

- (UIButton *) createButtonForFrame:(CGRect) frame withImage:(NSString *) image title:(NSString *) title {
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height, -16, -5, -button.titleLabel.intrinsicContentSize.width)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.currentImage.size.height+10, -button.currentImage.size.width, 0, 0)];
    [button setTitleColor:ATRGBA(138, 149, 157, 1.0) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    return button;
}

- (UIButton *)phoneConsult {
    if (!_phoneConsult) {
        _phoneConsult = [[UIButton alloc] initWithFrame:CGRectMake(173, 12, ATSCREEN_WIDTH - 188, 40)];
        _phoneConsult.layer.cornerRadius = 10.0;
        _phoneConsult.layer.masksToBounds = YES;
        _phoneConsult.backgroundColor = ATMainTonalColor;
        [_phoneConsult setTitle:@"电话咨询" forState:UIControlStateNormal];
        [_phoneConsult addTarget:self action:@selector(phoneConsultAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneConsult;
}

- (void) collectAction {
    
    //收藏
    [[DBManager shareInstance]insertData:self.shareHouseJsonModel table:@"roomInfo" columns:@"area_name, pic_main, hire_way, is_charter, latlon, bathroom, subdistrict_id, room_direction, virtualNumber, rent_area, livingroom, subdistrict_name, house_source, floor_area, subway_desc, bedroom, is_monthly_pay, house_main_image, month_rent, room_type, house_info_concat, house_info_concat_two, no_renter_commission, publish_date, house_id, is_discount, subway_line, search_subway, search_subway_distance, is_collect, private_bathroom, labels, nshelves, comprehensive_score, rank_weight, is_topic, is_proxy_served, is_true_photo, house_photo_num, fangdong_say, is_qiye_fangdong, is_tu_plus, is_open_fee, only_one_price, house_now_status, authState, agency_type, has_shop, lanPortrait, lanName, lanNum, lanLable, look_any, has_juzhu, side_desc, co_id"];
    
    
    [CLProgressHUD showInView:self.view delegate:self title:@"收藏成功" duration:1.0];
    
}

- (void) reservationAction {
//预约
    
    
}

- (void) phoneConsultAction {
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(+86)18811041045"]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 无用代码，待研究的
- (void)waste {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 64, 64)];
    [button setImage:[UIImage imageNamed:@"unCollect"] forState:UIControlStateNormal];
    [button setTitle:@"收藏" forState:UIControlStateNormal];
    //        得到imageView和titleLabel的宽、高
    //        CGFloat imageWith = button.imageView.frame.size.width;
    //        CGFloat imageHeight = button.imageView.frame.size.height;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    //        由于iOS8中titleLabel的size为0，用下面的这种设置
    labelWidth = button.titleLabel.intrinsicContentSize.width;//37
    labelHeight = button.titleLabel.intrinsicContentSize.height;//21.5
    //        NSLog(@"------------>lableWidth:%f, ---------->labelHeight:%f", labelWidth, labelHeight);
    
    CGFloat imageWidth = 0.0;
    CGFloat imageHeight = 0.0;
    imageWidth = button.currentImage.size.width + 24;
    imageHeight = button.currentImage.size.height + 24;
    
    //        NSLog(@"---------->imageWidth:%f， -------->%f", imageWidth, imageHeight);
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height, -16, -5, -button.titleLabel.intrinsicContentSize.width)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.currentImage.size.height+10, -button.currentImage.size.width, 0, 0)];
    
    //        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];//frame = (9.5 20; 24 24)
    //        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];// frame = (34 26; 20.5 12)
    //        [button setImageEdgeInsets:UIEdgeInsetsMake(-20, -1.5, 24, 24)];//frame = (2 -2; 24 24)
    //        [button setImageEdgeInsets:UIEdgeInsetsMake(-9.5, -20, 0, 0)]; //frame = (-0.5 15; 24 24)
    //        [button setImageEdgeInsets:UIEdgeInsetsMake(-9.5, -35, 0, 0)]; //frame = (-8 15; 24 24);
    //        [button setImageEdgeInsets:UIEdgeInsetsMake(-9.5, 0, 0, 0)]; //frame = (9.5 15; 24 24):https://www.jianshu.com/p/0d3dbc30fad5
    //        UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    [button setTitleColor:ATRGBA(138, 149, 157, 1.0) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    [self.suspensionView addSubview: button];
}

@end
