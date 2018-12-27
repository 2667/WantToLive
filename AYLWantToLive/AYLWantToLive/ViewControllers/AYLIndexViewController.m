//
//  AYLIndexViewController.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/19.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "AYLIndexViewController.h"
#import "IndexHeardView.h"
#import "RoomListCell.h"
#import "CityViewController.h"
#import "JSDropDownMenu.h"
#import "RoomInfo.h"
#import "MJRefreshAutoNormalFooter.h"
#import "ZhengViewController.h"
#import "AYLDetailViewController.h"
#import "HeViewController.h"

#import "DWQSearchController.h"

static NSString *const RoomListCellIdentifier = @"RoomListCellIdentifier";

@interface AYLIndexViewController ()<UITableViewDelegate, UITableViewDataSource, IndexHeardViewDelegate, JSDropDownMenuDataSource, JSDropDownMenuDelegate>

@property(nonatomic, strong)UIButton *leftButton;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIImageView *topImageView;

@property(nonatomic, strong)UIView *tapView;

@property(nonatomic, strong)IndexHeardView *indexHeardView;

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

@implementation AYLIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isShowMenu = NO;
    self.p_number = 1;
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
    //创建导航按扭
    [self createNavigationButtons];
    
    self.menu = ({
        JSDropDownMenu *muenView = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, NavigatorHeight) andHeight:44];
        [muenView setDelegate:self];
        [muenView setDataSource:self];
        
        muenView;
    });
    
    [self.view addSubview:self.menu];
    
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


//创建导航按扭
-(void)createNavigationButtons{
    self.leftButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"北京" forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, 50, 50)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - action
//选择城市
-(void)selectCity{
    CityViewController *cityVC = [[CityViewController alloc]init];
    cityVC.currentCityString=@"北京";
    cityVC.selectString=^(NSString *city){
        [self.leftButton setTitle:city forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:cityVC animated:YES];
}

//点击搜索
-(void)tapSearch{
    NSLog(@"__func__ >> %s",__func__);
    
    
    DWQSearchController *searchC = [[DWQSearchController alloc]init];
    searchC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchC animated:YES];
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

#pragma mark - UIScrollViewDelegate(缩放)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = ScreenWidth;
    CGFloat yOffset = scrollView.contentOffset.y  ;
    if (yOffset < 0) {
        CGFloat totalOffset = 120 + ABS(yOffset);
        CGFloat f = totalOffset / 120;
        self.topImageView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
    }
}


#pragma mark - IndexHeardViewDelegate
-(void)selectJumpPage:(NSInteger)type{
    if (type == 0) {
        NSLog(@"0");
        ZhengViewController *zhengVC = [[ZhengViewController alloc]init];
        zhengVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zhengVC animated:YES];
        
    }else{
        NSLog(@"1");
        
        HeViewController *heVC = [[HeViewController alloc]init];
        heVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:heVC animated:YES];
    }
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
    }else if (column==2){
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

    }else {

        return self.rankArray[indexPath.row];
    }
    
    return 0;
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
}


#pragma mark - setter
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        CGFloat tabelViewH = ScreenHeight - (NavigatorHeight + SafeAreaBottomHeight + TabBarHeight)-44;
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavigatorHeight+44, ScreenWidth, tabelViewH)
                                                 style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        
        //tableView -> headView
        self.topImageView = ({
            UIImageView *headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headImageView"]];
            headView.frame = CGRectMake(0, 0, ScreenWidth, 120);
            headView;
        });
        
        self.tapView = ({
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(14, (150), ScreenWidth - 28, 30)];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 8;
            //给图层添加一个有色边框 
            view.layer.borderWidth = 1;
            view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
            [label setText:@"您想住在哪"];
            [label setTextColor:[UIColor lightGrayColor]];
            [label setFont:[UIFont systemFontOfSize:15]];
            label.center = CGPointMake(ScreenWidth/2, 15);
            [view addSubview:label];
            
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seach"]];
            CGFloat labelX = CGRectGetMinX(label.frame), labelY = CGRectGetMinY(label.frame);
            [imgView setFrame:CGRectMake((labelX - 30), labelY+7.5, 15, 15)];
            [view addSubview:imgView];
            [view setBackgroundColor:[UIColor clearColor]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSearch)];
            [view addGestureRecognizer:tap];
            
            view;
        });
        
        self.indexHeardView = ({
            
            IndexHeardView *view = [[IndexHeardView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tapView.frame), ScreenWidth, 114)];
            [view setDelegate:self];
            view;
        });
        
        
        
        _tableView.tableHeaderView = ({
            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
            back.backgroundColor = [UIColor clearColor];
            [back addSubview:self.topImageView];
            [back addSubview:self.tapView];
            [back addSubview:self.indexHeardView];
           // [back addSubview:self.menu];
            back;
        });
        
        //tableView -> cell
        [_tableView registerNib:[UINib nibWithNibName:@"RoomListCell" bundle:nil] forCellReuseIdentifier:RoomListCellIdentifier];
        
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}




@end
