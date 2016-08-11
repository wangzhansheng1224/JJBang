//
//  MbClassifyCollectionCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBClassifyCollectionView.h"
#import "ShopClassifyCell.h"
#import "ShopClassifyModel.h"
#import "OrgListController.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"
#import "CourseListController.h"
#import "ActivityController.h"
#import "ClerkListController.h"
#import "TeacherListController.h"
@interface MBClassifyCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionViewFlowLayout * layout;
@property(nonatomic,assign) CGSize itemSize;
@property(nonatomic,strong) NSMutableArray * shopClassifyArray;

@end
@implementation MBClassifyCollectionView





static NSInteger const cols = 4;
static CGFloat const margin = 1;
static NSString * const cellID = @"cell";
#define  cellWH  ((Screen_Width - (cols - 1) * margin) / cols)
-(UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(cellWH, cellWH-10);
        layout.minimumInteritemSpacing = margin ;
        layout.minimumLineSpacing = margin;
        _layout = layout;
    }
    return _layout;
    
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize
{
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        self.bounces = NO;
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ShopClassifyCell class] forCellWithReuseIdentifier:cellID];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.shopClassifyArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShopClassifyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.classifyModel = self.shopClassifyArray[indexPath.row];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JJBLog(@"点击了%ld行，第%ld列",indexPath.section,indexPath.row);
    if (indexPath.row == 0) {
        
        //课程
        CourseListController * couseListVC = [[CourseListController alloc]init];
        UITabBarController *controller=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *navController= (UINavigationController*)[controller selectedViewController];
        [navController pushViewController:couseListVC animated:YES];
        
        
    }else if (indexPath.row == 1)
    {
        //活动
        ActivityController * activityVC = [[ActivityController alloc]init];
        
    }else if(indexPath.row == 2)
    {
        //店员
//        ClerkListController * clerkListVC = [];
        ClerkListController * clerkListVC = [[ClerkListController alloc]init];
        
        
    }else if(indexPath.row == 3)
    {
        //老师
        TeacherListController * teacherListVC = [[TeacherListController alloc]init];
        
        
    }else if(indexPath.row == 4)
    {
        //街区
        
    }else if(indexPath.row == 5)
    {
        //儿童成长
        
    }else if(indexPath.row == 6)
    {
        //社区商城
        
    }else if(indexPath.row == 7)
    {
        //机构
        OrgListController * orgListVC = [OrgListController alloc];
//        UINavigationController * navControl = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        
        
//        UIApplication * app = [[UIApplication sharedApplication]delegate];
//        UINavigationController * nav = app.navController;
//    UINavigationController * navControl  =  [(AppDelegate *)[[UIApplication sharedApplication]delegate]navControl];
        AppDelegate * nav = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        [nav.navController  pushViewController:orgListVC animated:YES];

    }
    
}

#pragma 
#pragma mark - getter and setter
-(NSMutableArray *)shopClassifyArray
{
    if (_shopClassifyArray == nil) {
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shopClassify.plist" ofType:nil]];
        NSMutableArray * tmp = [NSMutableArray array];
        for (NSDictionary * dict in dictArray) {
            ShopClassifyModel * classifyModel = [ShopClassifyModel classifyWithDict:dict];
            [tmp addObject:classifyModel];
        }
        _shopClassifyArray = tmp;
    }
    return _shopClassifyArray;
}
@end

