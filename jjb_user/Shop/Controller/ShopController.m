//
//  ShopController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopController.h"
#import "SHopIndexAPIManager.h"
#import "LoginViewController.h"

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

/**
 *  首页主控制器
 */


#define kPageCount 3    //广告位的数量
static NSString * const MBNewActivityCellIdentifier = @"MBNewActivityCellIdentifier";
static NSString * const MBSaleCellIdentifier = @"MBSaleCellIdentifier";
static NSString * const MBVideoCellIdentifier = @"MBViderCellIdentifier";
static NSString * const MBStarStudentCellIdentifier = @"MBStarStudentCellIdentifier";
static NSString * const MBStarTeacherCellIdentifier = @"MBStarTeacherCellIdentifier";
static NSString * const MBStarCouseCellIdentifier = @"MBStarCouseCellIdentifier";
static NSString * const ShopClassifyCellIdentifier = @"ShopClassifyCellIdentifier";
//static NSInteger const cols = 4;
//static CGFloat const margin = 20.0f;
//#define classCellWidth =  ((Screen_Width -(cols -1) * margin)/cols)



@interface ShopController()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) LDAPIBaseManager *shopIndexAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> shopIndexReformer;
@property(nonatomic,strong) UIButton * LoginButton;      //点击登录测试按钮
@property(nonatomic,strong) UIScrollView * scrollView;  //banner位
@property(nonatomic,strong) UIPageControl * pageControl;
@property(nonatomic,weak) NSTimer * Timer;
@property(nonatomic,weak) UICollectionView * collectionView;

@end

@implementation ShopController

#pragma -
#pragma mark- life cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;

    [self.shopIndexAPIManager loadData];
    [self setUpNav];
        //banner位
    [self setUpBanner];
    //所有的cell
    [self setupChildViewCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
//    [self setupNewActivity];
//    [self setupsale];
//    [self setupVideo];
//    [self setupStarStudents];
//    [self setupStarTeacher];
//    [self setupStarCourse];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
 
}

#pragma -
#pragma mark - private methods
//自定义导航栏
-(void)setUpNav
{
    UIBarButtonItem * scanButton = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"scan"] highImage:[UIImage imageNamed:@"scan"] target:self action:@selector(gotoScan)];
    self.navigationItem.rightBarButtonItem = scanButton;
    
    UIBarButtonItem * loactionButton =[[UIBarButtonItem alloc] initWithTitle:@"合肥市" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoLocation)];
    self.navigationItem.leftBarButtonItem=loactionButton;
    self.navigationItem.leftBarButtonItem = loactionButton;
    self.navigationItem.title = @"望湖公园店";
}

-(void)setupChildViewCell
{
    [self.tableView registerClass:[MBNewActivityCell class] forCellReuseIdentifier:MBNewActivityCellIdentifier];
//    [self.tableView registerClass:[MBSaleCell class] forCellReuseIdentifier:MBSaleCellIdentifier];
    [self.tableView registerClass:[MBVideoCell class] forCellReuseIdentifier:MBVideoCellIdentifier];
//    [self.tableView registerClass:[MBStarStudentCell class] forCellReuseIdentifier:MBStarStudentCellIdentifier];
//    [self.tableView registerClass:[MBStarTeacherCell class] forCellReuseIdentifier:MBStarTeacherCellIdentifier];
    [self.tableView registerClass:[MBStarCouseCell class] forCellReuseIdentifier:MBStarCouseCellIdentifier];
    
}
/*
//最新活动
-(void)setupNewActivity
{
    
}
//优惠商品
-(void)setupsale
{
    
}
//直播间
-(void)setupVideo
{
    
}

//明星学员
-(void)setupStarStudents
{
    
}
//明星老师
-(void)setupStarTeacher
{
    
}
//明星课程
-(void)setupStarCourse
{
    
}
 */
//扫描
-(void)gotoScan
{

    [self setUpScanStyle];
}

-(void)setUpScanStyle
{
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
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //添加一些扫码或相册结果处理
    ScanViewController *vc = [ScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//定位
-(void)gotoLocation
{
    JJBLog(@"%s",__func__);

}
//点击登录
-(void)loginClick
{
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
//banner位
-(void)setUpBanner
{
    CGFloat width = self.scrollView.width;
    CGFloat height = self.scrollView.height;
    
    for(int i = 0 ; i <kPageCount; i++)
    {
        UIImageView * imageView  = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(width * i, 0, width, height);
        NSString * imageName = [NSString stringWithFormat:@"ima%d",i];
       
//        imageView .image = [UIImage imageNamed:imageName];
        imageView.image = [UIImage imageNamed:@"img_default"];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize= CGSizeMake(kPageCount * width, 0);
    self.pageControl.numberOfPages = kPageCount;
    self.pageControl.currentPageIndicatorTintColor = COLOR_ORANGE;
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
//        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-5);
        make.top.equalTo(self.view.mas_top).offset(100);
        
    }];
//    self.pageControl.frame = CGRectMake(100, 100, 200, 30);
    self.scrollView.delegate = self;
    
    [self addPageTimer];
    
    
}
//对定时器操作
-(void)addPageTimer
{
    self.Timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updatePage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.Timer forMode:NSRunLoopCommonModes];
}

-(void)removePageTimer
{
    [self.Timer invalidate];
}
//切换界面
-(void)updatePage
{
    //获取当前的页码
    NSInteger currentPageIndex = self.pageControl.currentPage;
    currentPageIndex++;
    if (currentPageIndex >= kPageCount) {
        currentPageIndex = 0;
    }
    CGPoint offset = CGPointMake(currentPageIndex * self.scrollView.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}
//更多按钮点击事件
-(void)buttonMoreClick:(UIButton *)btn
{
    JJBLog(@"%s",__func__);
}

#pragma 
#pragma mark - UITableViewDataSource and UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
/*
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"最新活动";
    }else if(section == 1)
    {
        return @"优惠商品";
    }else if (section == 2)
    {
        return @"直播间";
    }else if(section == 3)
    {
        return @"明星学员";
    }else if(section == 4)
    {
        return @"明星老师";
    }else
    {
        return @"热门课程";
    }
    
    
    
}*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section == 0)
//    {
//        MBNewActivityCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBNewActivityCellIdentifier forIndexPath:indexPath];
//        return cell;
//        UITableViewCell * cell = [[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        MBClassifyCollectionView * collectionView = [[MBClassifyCollectionView alloc]initWithFrame:CGRectMake(0, 2, Screen_Width, 170) collectionViewItemSize:CGSizeMake(0, 0)];
        [cell.contentView addSubview:collectionView];
        return cell;

    }
    else if(indexPath.section== 1)
    {
        MBNewActivityCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBNewActivityCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if(indexPath.section == 2)
    {
//        MBSaleCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBSaleCellIdentifier forIndexPath:indexPath];
//        return cell;
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        MBSaleCollectionView * saleCollectionView = [[MBSaleCollectionView alloc]initWithFrame:CGRectMake(0, 2, Screen_Width, 200) collectionViewItemSize:CGSizeMake(0, 0)];
        [cell.contentView addSubview:saleCollectionView];
        return cell;
    }
    else if(indexPath.section ==3)
    {
        MBVideoCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBVideoCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if(indexPath.section == 4)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        MBStarStudentCollectionView * starStudentView = [[MBStarStudentCollectionView alloc]initWithFrame:CGRectMake(0, 2, Screen_Width, 200)];
        [cell.contentView addSubview:starStudentView];
        return cell;
        
    }
    else if(indexPath.section == 5)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        MBStarTeacherCollectionView * starTeacherView = [[MBStarTeacherCollectionView alloc]initWithFrame:CGRectMake(0, 2, Screen_Width, 200)];
        [cell.contentView addSubview:starTeacherView];
        return cell;
        
    }else
    {
        MBStarCouseCell * cell = [tableView dequeueReusableCellWithIdentifier:MBStarCouseCellIdentifier forIndexPath:indexPath];
        return cell;
    }

//    }
//    else if (indexPath.section == 1)
//    {
//        MBSaleCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBSaleCellIdentifier forIndexPath:indexPath];
//        return cell;
//
//    }
//    else if(indexPath.section == 2)
//    {
//        MBVideoCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBVideoCellIdentifier forIndexPath:indexPath];
//        return cell;
//
//    }
//    else if(indexPath.section == 3)
//    {
//        MBStarStudentCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBStarStudentCellIdentifier forIndexPath:indexPath];
//        return cell;
//
//    }
//    else if (indexPath.section == 4)
//    {
//        MBStarTeacherCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBStarTeacherCellIdentifier forIndexPath:indexPath];
//        return cell;
//
//    }
//    else
//    {
//        MBStarCouseCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MBStarCouseCellIdentifier forIndexPath:indexPath];
//        return cell;
//
//    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    sectionView.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_GRAY forState:UIControlStateNormal];
    button.titleLabel.font = H4;
    [button sizeToFit];
    [button addTarget:self action:@selector(buttonMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionView.mas_top);
        make.right.equalTo(sectionView.mas_right).offset(-16);
        make.bottom.equalTo(sectionView.mas_bottom);
    }];
    UILabel * label = [[UILabel alloc]init];
    label.text = @"最新活动";
    label.textAlignment = NSTextAlignmentLeft;
    [sectionView addSubview:label];
    [label sizeToFit];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button.mas_centerY);
        make.left.equalTo(sectionView.mas_left).offset(20);
    }];
    

    
    return sectionView;

}
#pragma 
#pragma mark - collectionDelegate and collectionDataSouce
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 8;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    ShopClassifyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ShopClassifyCell class] forIndexPath:<#(nonnull NSIndexPath *)#>];
//}
//









#pragma mark
#pragma mark -   UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = (NSInteger)(self.scrollView.contentOffset.x/scrollView.width+0.5);
    self.pageControl.currentPage = currentPage;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self removePageTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addPageTimer];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSDictionary *reformedShopIndexData = [manager fetchDataWithReformer:self.shopIndexReformer];
}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{@"lng":@"117.10",@"lat":@"40.13"};
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
//banner位
-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
    //保持宽高比
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width * 0.336)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
//        [self.view addSubview:scrollView];
        self.tableView.tableHeaderView = scrollView;
        _scrollView = scrollView;
    }
    
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        UIPageControl * pageControl = [[UIPageControl alloc]init];
        pageControl.currentPage = 0;
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        [self.view addSubview:pageControl];
        _pageControl  =  pageControl;
        
    }
    return _pageControl;
}
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
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled = NO; //不允许滚动
        collectionView.bounces = NO;
        _collectionView = collectionView;
        _collectionView.backgroundColor = [UIColor whiteColor];

    }
    return _collectionView;
}
@end
