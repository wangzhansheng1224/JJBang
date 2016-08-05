//
//  RHMenuViewController.m
//  RHProject
//
//  Created by Check on 16/4/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "RHMenuViewController.h"
#import "RHMenuView.h"
#import "RHHeader.h"

@interface RHMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NSArray * controllers;

@property (nonatomic,strong)NSArray * menuTitles;

@property (nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,strong)RHMenuView * menuView;

@end

@implementation RHMenuViewController

- (instancetype)initWithViewControllers:(NSArray *)controllers andMenuTitles:(NSArray *)menuTitles{
    self = [super init];
    
    if (self) {
        
        _controllers = [NSArray arrayWithArray:controllers];
        
        for (int i = 0; i < _controllers.count; i ++) {
            
            UIViewController * vc = (UIViewController *)_controllers[i];
            
            [self addChildViewController:vc];
        }
        
        _menuTitles = [NSArray arrayWithArray:menuTitles];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createMenuView];
    [self createCollectionView];
}

#pragma mark -- create menuView
- (void)createMenuView{
    
    _menuView = [[RHMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, ITEM_HEIGHT) andMenuTitles:_menuTitles andBlock:^(NSInteger index) {
        
        [_collectionView setContentOffset:CGPointMake(SCREEN_W*index, 0) animated:YES];
        
    }];
    
    [self.view addSubview:_menuView];
}

#pragma mark -- create collectionView
- (void)createCollectionView{
    //在CollectionView创建之前  创建需要布局的对象
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //两列之间的距离
    flowLayout.minimumInteritemSpacing = 0;
    //两行之间的距离
    flowLayout.minimumLineSpacing = 0;
    
    CGRect frame = CGRectMake(0, 20+CGRectGetHeight(_menuView.frame), SCREEN_W, SCREEN_H-CGRectGetHeight(_menuView.frame)-20);

    //设置布局对象的大小(长和宽)
    flowLayout.itemSize = frame.size;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    
//    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //设置代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    //设置翻页
    _collectionView.pagingEnabled = YES;
    
    _collectionView.bounces = NO;//反弹
    
    _collectionView.showsHorizontalScrollIndicator = NO;//水平滚动条
    
    //注册cell  复用
    [_collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:COLLECTION_CELL];
    
    [self.view addSubview:_collectionView];
    
    //避免CollectionView下滑
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark -- collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _menuTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL forIndexPath:indexPath];
    
    UIViewController * controller = _controllers[indexPath.row];
    
    controller.view.frame = cell.contentView.bounds;
    
    [cell.contentView addSubview:controller.view];
    
    return cell;
}


#pragma mark -- scrollView delegate
//翻页结束触发的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _collectionView) {
        
        NSInteger selectIndex = _collectionView.contentOffset.x/SCREEN_W;
        
        _menuView.selectIndex = selectIndex;//属性传值
//        [_menuView changeSelectItemWithIndex:selectIndex];
    }
    
    //这里如果不做判断写成如下效果  也可以达到效果  判断是否是多余
    
//    NSInteger index = scrollView.contentOffset.x/SCREEN_W;
//    
//    [_menuView changeSelectItemWithIndex:index];
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
