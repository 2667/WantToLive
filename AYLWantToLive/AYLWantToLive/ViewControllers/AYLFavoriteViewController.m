//
//  AYLFavoriteViewController.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/19.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "AYLFavoriteViewController.h"
#import "RoomListCell.h"
#import "RoomInfo.h"
static NSString *const RoomListCellIdentifier = @"RoomListCellIdentifier";

@interface AYLFavoriteViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *dataList;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation AYLFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataList = [NSMutableArray array];
    
    [self initUI];
}

//初始化UI
-(void)initUI{
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
    
    self.dataList = [[DBManager shareInstance]queryData:nil table:@"roomInfo"];
    
    // 此处添加刷新tableView数据的代码
    [refreshControl endRefreshing];
    [self.tableView reloadData];// 刷新tableView即可
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

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        CGFloat tabelViewH = ScreenHeight - (NavigatorHeight + SafeAreaBottomHeight + TabBarHeight);
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavigatorHeight, ScreenWidth, tabelViewH)
                                                 style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        
        //tableView -> cell
        [_tableView registerNib:[UINib nibWithNibName:@"RoomListCell" bundle:nil] forCellReuseIdentifier:RoomListCellIdentifier];
    }
    return _tableView;
}


@end
