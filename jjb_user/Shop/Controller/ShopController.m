//
//  ShopController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopController.h"
#import "SHopIndexAPIManager.h"
#import "ShopIndexReformer.h"
#import "LoginViewController.h"
#import "TitleBar.h"

#import <LBXScanViewController.h>
#import "ScanViewController.h"
#import "MBNewActivityCell.h"
#import "MBSaleCell.h"
#import "MBVideoCell.h"
#import "MBStarStudentCell.h"
#import "MBStarTeacherCell.h"
#import "MBStarCouseCell.h"
#import "ShopClassifyCell.h"
#import "MBClassifyCollectionView.h"
#import "MBSaleCollectionView.h"
#import "MBStarStudentCollectionView.h"
#import "MBStarTeacherCollectionView.h"
#import "CourseKeys.h"
#import "ShopListController.h"
#import "MBLocation.h"
#import "MBLocationManager.h"
#import "RHADScrollView.h"
#import "MBNavgationCenterView.h"

/**
 *  首页主控制器
 */


static NSString * const MBNewActivityCellIdentifier = @"MBNewActivityCellIdentifier";
static NSString * const MBSaleCellIdentifier = @"MBSaleCellIdentifier";
static NSString * const MBVideoCellIdentifier = @"MBViderCellIdentifier";
static NSString * const MBStarStudentCellIdentifier = @"MBStarStudentCellIdentifier";
static NSString * const MBStarTeacherCellIdentifier = @"MBStarTeacherCellIdentifier";
static NSString * const MBStarCouseCellIdentifier = @"MBStarCouseCellIdentifier";
static NSString * const ShopClassifyCellIdentifier = @"ShopClassifyCellIdentifier";

@interface ShopController()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource, RHADScrollViewDelegate>
@property (nonatomic,strong) LDAPIBaseManager *shopIndexAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> shopIndexReformer;
//@property(nonatomic,strong) UIScrollView * scrollView;  //banner位
//@property(nonatomic,strong) UIPageControl * pageControl;
//@property(nonatomic,weak) NSTimer * Timer;

@property(nonatomic,weak) UICollectionView * collectionView;
@property (nonatomic,strong) UIBarButtonItem * scanButton;  //扫描按钮
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ScanViewController *scanController;
@property(nonatomic,strong) NSDictionary *dataDic;
@property(nonatomic,assign) double currentLongitude;  //当前经度
@property(nonatomic,assign) double currentLatitude;    //当前纬度
@property(nonatomic,copy) NSString * currentShopID; //当前店铺ID
@property(nonatomic,copy) NSString * currentShopName; //当前店铺名称
@property(nonatomic,strong) RHADScrollView * adScrollView;
@property(nonatomic,strong) MBNavgationCenterView * coustomNavCenterView; //自定义的导航栏中间View

@end

@implementation ShopController

#pragma -
#pragma mark- life cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self.view addSubview:self.coustomNavCenterView];
    self.navigationItem.titleView = self.coustomNavCenterView;
    self.navigationItem.rightBarButtonItem =self.scanButton;

    
    [self.view addSubview:self.tableView];
    [self.shopIndexAPIManager loadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(changeName:) name:@"changeShopName" object:nil];
    
    
    MBLocation * location =[MBLocation shareMBLocation];
    
    [location getCurrentLocation:^(NSDictionary * dict) {
        self.currentLongitude = [dict[@"longitude"] doubleValue];
        self.currentLatitude  = [dict [@"latitude"] doubleValue];
    }];
    
    if (self.currentShopName) {
        _coustomNavCenterView.shopNameLabel.text = self.currentShopName;
        
    }

    //切换门店之后tableView自动置顶
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];

    }


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)changeName:(NSNotification *)notification
{
    JJBLog(@"%@",notification);
    NSString * string = notification.userInfo[@"ShopIndexShopListName"];
    self.navigationItem.title = string;
    self.currentShopID = notification.userInfo[@"ShopIndexShopListID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentShopID forKey:@"currenShopID"];
//    [[NSUserDefaults standardUserDefaults]objectForKey:@"currenShopID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentShopName forKey:@"currntShopName"];
    
    [self.shopIndexAPIManager loadData];
}
#pragma -
#pragma mark - Events
//扫一扫
-(void)gotoScan:(id)sender
{
    [self.navigationController pushViewController:self.scanController animated:YES];
}
//更改店铺
-(void)changeShop:(UITapGestureRecognizer *)recognizer
{
    ShopListController * shopListVC = [[ShopListController alloc]init];
    shopListVC.shopListArray=self.dataDic[kShopIndexShopList];
    //    [self presentViewController:shopListVC animated:YES completion:nil];
    [self presentViewController:shopListVC animated:YES completion:^{
        
        _adScrollView.invalidate = YES;
    }];

}
//banner位
//-(void)setUpBanner
//{
//    CGFloat width = self.scrollView.width;
//    CGFloat height = self.scrollView.height;
//    NSArray *imgArr=self.dataDic[kShopIndexActImg];
//    for(int i = 0 ; i <[imgArr count]; i++)
//    {
//        NSDictionary *imgDic=imgArr[i];
//        UIImageView * imageView  = [[UIImageView alloc]init];
//        imageView.userInteractionEnabled=YES;
//        UITapGestureRecognizer *clickTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activityClick:)];
//        [imageView addGestureRecognizer:clickTapGestureRecognizer];
//        imageView.tag=[imgDic[kShopIndexActImgID] integerValue];
//        imageView.frame = CGRectMake(width * i, 0, width, height);
//            [imageView sd_setImageWithURL:[NSURL initWithImageURL:imgDic[kShopIndexActImgImagePath] Size:imageView.frame.size] placeholderImage:[UIImage imageNamed:@"img_default"]];
//        [self.scrollView addSubview:imageView];
//    }
//    self.scrollView.contentSize= CGSizeMake([imgArr count] * width, height);
//
//    
//    self.pageControl.numberOfPages = [imgArr count];
//    self.pageControl.currentPageIndicatorTintColor = COLOR_ORANGE;
//    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
////        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-5);
//        make.top.equalTo(self.scrollView.mas_bottom).offset(-30);
//        
//    }];
////    self.pageControl.frame = CGRectMake(100, 100, 200, 30);
//    self.scrollView.delegate = self;
//    
//    [self addPageTimer];
//    
//    
//}
////对定时器操作
//-(void)addPageTimer
//{
//    self.Timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updatePage) userInfo:nil repeats:YES];
//
//        [[NSRunLoop mainRunLoop] addTimer:self.Timer forMode:NSRunLoopCommonModes];
//    
//}
//
//-(void)removePageTimer
//{
//    [self.Timer invalidate];
//    self.Timer = nil;
//}
////切换界面
//-(void)updatePage
//{
//    //获取当前的页码
//    NSInteger currentPageIndex = self.pageControl.currentPage;
//    currentPageIndex++;
//    NSArray *imgArr=self.dataDic[kShopIndexActImg];
//    if (currentPageIndex >= [imgArr count]) {
//        currentPageIndex = 0;
//    }
//    CGPoint offset = CGPointMake(currentPageIndex * self.scrollView.width, 0);
//    [self.scrollView setContentOffset:offset animated:YES];
////    JJBLog(@"定时器时间==%lf",self.Timer.timeInterval);
//}
//
//-(void)activityClick:(UITapGestureRecognizer*)sender{
//    
//   UIViewController *controller=[[CTMediator sharedInstance] CTMediator_ActivityDetail:@{@"activityID":@(sender.view.tag)}];
//    [self.navigationController pushViewController:controller animated:YES];
//}

#pragma 
#pragma mark - UITableViewDataSource and UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==5) {
        NSArray* arrData=self.dataDic[kShopIndexCourseList];
        NSDictionary *dataDic=arrData[indexPath.row];
        UIViewController* controller=[[CTMediator sharedInstance] CTMediator_CourseDetail:@{@"courseID":dataDic[kCourseID]}];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section==1) {
        NSDictionary *actDic=self.dataDic[kShopIndexActList];
        UIViewController* controller=[[CTMediator sharedInstance] CTMediator_ActivityDetail:@{@"activityID":actDic[kShopIndexActID]}];
        [self.navigationController pushViewController:controller animated:YES];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==5) {
        NSArray* arrData=self.dataDic[kShopIndexCourseList];
        if (arrData) {
            return [arrData count];
        }
        return 0;
    }
    else if(section==1)
    {
        NSArray* arrData=self.dataDic[kShopIndexActList];
        return [arrData count];
    }
    else{
        return 1;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopClassifyCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        MBClassifyCollectionView * collectionView = [[MBClassifyCollectionView alloc]initWithFrame:CGRectMake(0, 2, Screen_Width, Screen_Width/2.0) collectionViewItemSize:CGSizeMake(0, 0)];
        [cell.contentView addSubview:collectionView];
        return cell;
    }
    else if(indexPath.section== 1)
    {
        MBNewActivityCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBNewActivityCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.dataDic[kShopIndexActList][indexPath.row]];
        return cell;
    }
    else if(indexPath.section == 2)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MBSaleCellIdentifier forIndexPath:indexPath];
        TitleBar * titleBar=[[TitleBar alloc] initWithTitle:@"优惠商品"];
        titleBar.frame=CGRectMake(0, 0, Screen_Width, 30);
        [cell.contentView addSubview:titleBar];
        [titleBar moreButtonClick:^(TitleBar *sender) {
          UIViewController *goodsList=  [[CTMediator sharedInstance] CTMediator_GoodsList:nil];
            [self.navigationController pushViewController:goodsList animated:YES];
        }];
        
        MBSaleCollectionView * saleCollectionView = [[MBSaleCollectionView alloc]initWithFrame:CGRectMake(0, 30, Screen_Width, (Screen_Width-40.0f)/2.0f+30.0f) collectionViewItemSize:CGSizeMake(0, 0)];
        [saleCollectionView configWithData:self.dataDic[kShopIndexGoodsList]];
        [cell.contentView addSubview:saleCollectionView];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, (Screen_Width-40.0f)/2.0f+30.0f+30.0f, Screen_Width, 10)];
        lineView.backgroundColor=COLOR_LIGHT_GRAY;
        [cell.contentView addSubview:lineView];
        
        return cell;
    }
//    else if(indexPath.section ==3)
//    {
//        MBVideoCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBVideoCellIdentifier forIndexPath:indexPath];
//        return cell;
//    }
    else if(indexPath.section == 3)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MBStarStudentCellIdentifier forIndexPath:indexPath];
        TitleBar * titleBar=[[TitleBar alloc] initWithTitle:@"明星学员"];
        titleBar.frame=CGRectMake(0, 0, Screen_Width, 30);
        [cell.contentView addSubview:titleBar];
        [titleBar moreButtonClick:^(TitleBar *sender) {
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_StudentList:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }];
       
        MBStarStudentCollectionView * starStudentView = [[MBStarStudentCollectionView alloc]initWithFrame:CGRectMake(0, 30, Screen_Width, Screen_Width/2.0f)];
        [starStudentView configWithData:self.dataDic[kShopIndexSdtList]];
        [cell.contentView addSubview:starStudentView];
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, Screen_Width/2.0f+30, Screen_Width, 10)];
        lineView.backgroundColor=COLOR_LIGHT_GRAY;
        [cell.contentView addSubview:lineView];
        return cell;
        
    }
    else if(indexPath.section == 4)
    {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MBStarTeacherCellIdentifier forIndexPath:indexPath];
        TitleBar * titleBar=[[TitleBar alloc] initWithTitle:@"明星老师"];
        titleBar.frame=CGRectMake(0, 0, Screen_Width, 30);
        [cell.contentView addSubview:titleBar];
        [titleBar moreButtonClick:^(TitleBar *sender) {
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_StarTeacherList:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }];
        
        MBStarTeacherCollectionView * starTeacherView = [[MBStarTeacherCollectionView alloc]initWithFrame:CGRectMake(0, 30, Screen_Width, Screen_Width/2.0f)];
        [starTeacherView configWithData:self.dataDic[kShopIndexTechList]];
        
        [cell.contentView addSubview:starTeacherView];
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, Screen_Width/2.0f+30, Screen_Width, 10)];
        lineView.backgroundColor=COLOR_LIGHT_GRAY;
        [cell.contentView addSubview:lineView];
        
        TitleBar * nextBar=[[TitleBar alloc] initWithTitle:@"热门课程"];
        [nextBar moreButtonClick:^(TitleBar *sender) {
          UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CourseList:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }];
        nextBar.frame=CGRectMake(0, Screen_Width/2.0f+40,Screen_Width,30);
        [cell.contentView addSubview:nextBar];
        return cell;
        
    }else
    {
        MBStarCouseCell * cell = [tableView dequeueReusableCellWithIdentifier:MBStarCouseCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.dataDic[kShopIndexCourseList][indexPath.row]];
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
          return Screen_Width/2.0f+10;
    }
    if (indexPath.section==1) {
          return Screen_Width*2.0f/3.0f+90.0f;
    }
    if (indexPath.section==2) {
        return (Screen_Width-40.0f)/2.0f+30.0f+40.0f;
    }
//    if (indexPath.section==3) {
//        return Screen_Width*2.0f/3.0f+90.0f;
//    }
    if(indexPath.section==3)
    {
        return Screen_Width/2.0f+30.0f+10.f;
    }
    if(indexPath.section==4)
    {
        return Screen_Width/2.0f+30.0f+10.f+30.0f;
    }
      return Screen_Width/3.0f;
}

#pragma mark
#pragma mark -   UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSInteger currentPage = (NSInteger)(self.scrollView.contentOffset.x/scrollView.width+0.5);
//    self.pageControl.currentPage = currentPage;
//}

//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    [self removePageTimer];
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self addPageTimer];
//}

- (void)tapImageIndex:(NSInteger)index {
    NSArray * arr = self.dataDic[kShopIndexActImg];
    NSDictionary * dic = arr[index];
    NSLog(@"%@+++",dic);
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_ActivityDetail:@{@"activityID":dic[kShopIndexActImgID]}];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    self.dataDic = [manager fetchDataWithReformer:self.shopIndexReformer];
//    [self setUpBanner];
    NSArray * arr = self.dataDic[kShopIndexActImg];
    NSMutableArray * mutArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < arr.count; i++) {
        
        NSDictionary * dic = arr[i];
        
        [mutArr addObject:[NSString stringWithFormat:@"%@%@", ImageServer,dic[kShopIndexActImgImagePath]]];
        
    }
    _adScrollView = nil;
    
    self.adScrollView.arrPic = mutArr;
    _adScrollView.adHeight = Screen_Width*2.0f/3.0f;
    [_adScrollView play];
    
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
      [self.tableView.mj_header endRefreshing];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{@"lng":@(self.currentLongitude) ,@"lat":@(self.currentLatitude),@"shopId":self.currentShopID};
}

#pragma -
#pragma mark - getters and setters
- (LDAPIBaseManager *)shopIndexAPIManager {
    if (_shopIndexAPIManager == nil) {
        _shopIndexAPIManager = [ShopIndexAPIManager  sharedInstance];
        _shopIndexAPIManager.delegate=self;
        _shopIndexAPIManager.paramSource=self;
    }
    return _shopIndexAPIManager;
}

-(id<ReformerProtocol>) shopIndexReformer
{
    if (!_shopIndexReformer) {
        _shopIndexReformer=[[ShopIndexReformer alloc] init];
    }
    return _shopIndexReformer;
}
//banner位
//-(UIScrollView *)scrollView
//{
//    if (_scrollView == nil) {
//    //保持宽高比
//        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*2.0f/3.0f)];
//        scrollView.showsHorizontalScrollIndicator = NO;
//        scrollView.pagingEnabled = YES;
////        [self.view addSubview:scrollView];
//        self.tableView.tableHeaderView = scrollView;
//        _scrollView = scrollView;
//    }
//    
//    return _scrollView;
//}

//-(UIPageControl *)pageControl
//{
//    if (_pageControl == nil) {
//        _pageControl = [[UIPageControl alloc]init];
//        _pageControl.currentPage = 0;
//        _pageControl.hidesForSinglePage = YES;
//        _pageControl.userInteractionEnabled = NO;
//        [self.tableView addSubview:_pageControl];
//    }
//    return _pageControl;
//}
-(NSMutableArray *)groupsArray
{
    if (_groupsArray == nil) {
        _groupsArray = [NSMutableArray array];
    }
    return _groupsArray;
}
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionView * collectionView = [[UICollectionView alloc]init];
        collectionView.scrollEnabled = NO; //不允许滚动
        collectionView.bounces = NO;
        _collectionView = collectionView;
        _collectionView.backgroundColor = [UIColor whiteColor];

    }
    return _collectionView;
}

- (UIBarButtonItem *) scanButton{
    if (_scanButton==nil) {
        _scanButton=[UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"scan"] highImage:[UIImage imageNamed:@"scan"] target:self action:@selector(gotoScan:)];
    }
    return _scanButton;
}

-(UITableView*)tableView{
    
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 49-44-20) style:UITableViewStylePlain];
        _tableView.backgroundColor=COLOR_LIGHT_GRAY;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.shopIndexAPIManager loadData];
        }];
        
        [_tableView registerClass:[MBNewActivityCell class] forCellReuseIdentifier:MBNewActivityCellIdentifier];
        [_tableView registerClass:[MBVideoCell class] forCellReuseIdentifier:MBVideoCellIdentifier];
        [_tableView registerClass:[MBStarCouseCell class] forCellReuseIdentifier:MBStarCouseCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ShopClassifyCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MBStarTeacherCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MBStarStudentCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MBSaleCellIdentifier];
        
        
    }
    return _tableView;
}

- (ScanViewController*)scanController
{
    if (_scanController==nil) {
        _scanController=[[ScanViewController alloc] init];
        //设置扫码区域参数设置
        //创建参数对象
        LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
        
        //矩形区域中心上移，默认中心点为屏幕中心点
        style.centerUpOffset = 44;
        
        //扫码框周围4个角的类型,设置为外挂式
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
        
        //扫码框周围4个角绘制的线条宽度
        style.photoframeLineW = 6;
        
        //扫码框周围4个角的宽度
        style.photoframeAngleW = 24;
        
        //扫码框周围4个角的高度
        style.photoframeAngleH = 24;
        
        //扫码框内 动画类型 --线条上下移动
        style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
        
        //线条上下移动图片
        style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green"];
        
        _scanController.style = style;
        
        _scanController.isQQSimulator = YES;
        _scanController.isVideoZoom = YES;
    }
   return _scanController;
}

-(NSDictionary *) dataDic{
    if (!_dataDic) {
        _dataDic=[[NSDictionary alloc] init];
    }
    return _dataDic;
}

- (RHADScrollView *)adScrollView {
    
    if (!_adScrollView) {
        
        _adScrollView = [[RHADScrollView alloc] init];
        _adScrollView.frame = CGRectMake(0, 0, Screen_Width, Screen_Width*2.0f/3.0f);
        _adScrollView.delegate = self;
        
        self.tableView.tableHeaderView = _adScrollView;

    }
    return _adScrollView;
}

-(MBNavgationCenterView *)coustomNavCenterView
{
    if (_coustomNavCenterView == nil) {
        _coustomNavCenterView = [[MBNavgationCenterView alloc]initWithFrame:CGRectMake(40, 20, 100, 44)];
        _coustomNavCenterView.userInteractionEnabled = YES;
                        UITapGestureRecognizer * changeShopTapestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeShop:)];
        [_coustomNavCenterView addGestureRecognizer:changeShopTapestureRecognizer];
    }
    return _coustomNavCenterView;
}



@end
