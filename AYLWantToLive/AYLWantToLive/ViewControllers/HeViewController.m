//
//  HeViewController.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/26.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "HeViewController.h"



#import "RoomListCell.h"

#import "MJRefreshAutoNormalFooter.h"

#import "AYLDetailViewController.h"

#import "CLProgressHUD.h"

#import "JSDropDownMenu.h"

static NSString *const RoomListCellIdentifier = @"RoomListCellIdentifier";


@interface HeViewController ()<UITableViewDelegate, UITableViewDataSource, JSDropDownMenuDataSource, JSDropDownMenuDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)JSDropDownMenu *menu;

@property(nonatomic)BOOL isShowMenu;

//区域
@property(nonatomic, strong)NSArray *areaArray;
//租金
@property(nonatomic, strong)NSArray *rentArray;
//筛选
@property(nonatomic, strong)NSArray *screenArray;
//排序
@property(nonatomic, strong)NSArray *rankArray;

@property(nonatomic, strong)NSMutableArray *dataList;

@property(nonatomic)NSInteger p_number;

@end

@implementation HeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"合租";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initData];
    [self initUI];
}

#pragma mark - private

-(void)initData{
    
    self.dataList = [NSMutableArray array];
    
    NSArray *business = @[@"朝阳", @"海淀", @"丰台", @"东城", @"西城", @"崇文", @"宣武", @"石景山", @"昌平"];
    NSArray *subway = @[ @"1号线", @"2号线", @"3号线", @"4号线", @"5号线", @"6号线", @"7号线"];
    self.areaArray = @[@{@"title":@"不限", @"data":@[]},
                       @{@"title":@"商圈", @"data":business},
                       @{@"title":@"地铁", @"data":subway}];
    
    
    self.rentArray = @[@"不限", @"1000以下", @"1000-1500", @"1500-2000", @"2000-2500", @"2500-3000"];
    
    self.rankArray = @[@"默认排序", @"价格由高到低", @"价格由低到高", @"面积从小到大"];
    
    
}

//初始化UI
-(void)initUI{
    
    [self.view addSubview:self.menu];
    
    //创建导航按扭
    [self.view addSubview:self.tableView];
    
    [self setupRefresh];
}

// 下拉刷新
- (void)setupRefresh {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    
    [self.dataList removeAllObjects];
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    self.p_number = 1;
    NSDictionary *dic = @{@"P":[NSString stringWithFormat:@"%ld", self.p_number], @"S":@"15", @"city_id":@"238"
                          , @"from":@"4", @"hire_way":@"2", @"no_house":@"0"
                          , @"udid":@"", @"v":@"1.2.4"
                          , @"device_id":uuid
                          };
    
    [[DataManager shareInstance] getAllRoomList:dic callback:^(NSArray *result) {
        [self.dataList addObjectsFromArray:result];
        [self.tableView reloadData];
        
    }];
    
    // 此处添加刷新tableView数据的代码
    [refreshControl endRefreshing];
    [self.tableView reloadData];// 刷新tableView即可
}

-(void)loadMoreData{
    
    self.p_number += 1;
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSDictionary *dic = @{@"P":[NSString stringWithFormat:@"%ld", self.p_number], @"S":@"15", @"city_id":@"238"
                          , @"from":@"4", @"hire_way":@"2", @"no_house":@"0"
                          , @"udid":@"", @"v":@"1.2.4"
                          , @"device_id":uuid
                          };
    
    [[DataManager shareInstance] getAllRoomList:dic callback:^(NSArray *result) {
        [self.dataList addObjectsFromArray:result];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomInfo *model = [self.dataList objectAtIndex:indexPath.row];
    
    if (model.subway_desc.length > 0) {
        return 131;
    }else{
        return 131-29;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:RoomListCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:[self.dataList objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RoomInfo *model = [self.dataList objectAtIndex:indexPath.row];
    ATHouseDetailController *detailVC = [[ATHouseDetailController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.shareHouseJsonModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - JSDropDownMenuDataSource && JSDropDownMenuDelegate

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    if (column==0) {
        return 0.3;
    }
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {
            return self.areaArray.count;
        } else{
            NSDictionary *menuDic = [self.areaArray objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==1){
        return self.rentArray.count;
    } else if (column==2){
        return self.rankArray.count;
    }
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    if (self.isShowMenu == NO) {
        switch (column) {
            case 0:{
                return @"区域";
            }
                break;
            case 1:{
                return @"租金";
            }
                break;
            case 2:{
                return @"排序";
            }
                break;
            default:
                break;
        }
    }else{
        
    }
    
    
    return nil;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [self.areaArray objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [self.areaArray objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==1) {
        
        return self.rentArray[indexPath.row];
        
    } else {
        
        return self.rankArray[indexPath.row];
    }
    
    return 0;
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    
    [CLProgressHUD showSuccessInView:self.view delegate:nil title:nil duration:0.35];
    [self.dataList removeAllObjects];
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    self.p_number = 1;
    NSDictionary *dic = @{@"P":[NSString stringWithFormat:@"%ld", self.p_number], @"S":@"15", @"city_id":@"238"
                          , @"from":@"4", @"hire_way":@"2", @"no_house":@"0"
                          , @"udid":@"", @"v":@"1.2.4"
                          , @"device_id":uuid
                          };
    
    [[DataManager shareInstance] getAllRoomList:dic callback:^(NSArray *result) {
        [self.dataList addObjectsFromArray:result];
        [self.tableView reloadData];
        
    }];
}



#pragma mark - setter
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        CGFloat tabelViewH = ScreenHeight - (NavigatorHeight + SafeAreaBottomHeight + CGRectGetHeight(self.menu.frame));
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menu.frame), ScreenWidth, tabelViewH)
                                                 style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        
        //tableView -> cell
        [_tableView registerNib:[UINib nibWithNibName:@"RoomListCell" bundle:nil] forCellReuseIdentifier:RoomListCellIdentifier];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}


-(JSDropDownMenu *)menu{
    if(_menu == nil){
        _menu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, NavigatorHeight) andHeight:44];
        [_menu setDataSource:self];
        [_menu setDelegate:self];
    }
    return _menu;
}

@end
