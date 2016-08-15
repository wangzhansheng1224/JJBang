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
#import "HomePageActivityController.h"
#import "ClerkListController.h"
#import "TeacherListController.h"
#import "StreetControl.h"
@interface MBClassifyCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionViewFlowLayout * layout;
@property(nonatomic,assign) CGSize itemSize;
@property(nonatomic,strong) NSMutableArray * shopClassifyArray;

@end
@implementation MBClassifyCollectionView

static NSInteger const cols = 4;
static CGFloat const margin = 0;
static NSString * const cellID = @"cell";
#define  cellWH  ((Screen_Width - (cols - 1) * margin) / cols)
-(UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(cellWH, cellWH);
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
    UINavigationController * navControler =((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    if (indexPath.row == 0) {
        //课程
        CourseListController * couseListVC = [[CourseListController alloc]init];
        [navControler pushViewController:couseListVC animated:YES];
        
    }else if (indexPath.row == 1)
    {
        //活动
        HomePageActivityController * activityVC = [[HomePageActivityController alloc]init];
        [navControler pushViewController:activityVC animated:YES];
//        ClerkListController * clerkListVC = [[ClerkListController alloc]init];
//        [navControler pushViewController:clerkListVC animated:YES];
        
    }else if(indexPath.row == 2)
    {
        //店员
//        ClerkListController * clerkListVC = [];
        ClerkListController * clerkListVC = [[ClerkListController alloc]init];
        [navControler pushViewController:clerkListVC animated:YES];
        
    }else if(indexPath.row == 3)
    {
        //老师
        TeacherListController * teacherListVC = [[TeacherListController alloc]init];
        [navControler pushViewController:teacherListVC animated:YES];
        
    }else if(indexPath.row == 4)
    {
        //街区
        
        StreetControl * streetVC = [[StreetControl alloc]init];
        [navControler pushViewController:streetVC animated:YES];
        
    }else if(indexPath.row == 5)
    {
        //儿童成长
        StreetControl * streetVC = [[StreetControl alloc]init];
        [navControler pushViewController:streetVC animated:YES];
        
        
    }else if(indexPath.row == 6)
    {
        //社区商城
        StreetControl * streetVC = [[StreetControl alloc]init];
        [navControler pushViewController:streetVC animated:YES];
        
    }else if(indexPath.row == 7)
    {
        //机构
        OrgListController * orgListVC = [OrgListController alloc];
        [navControler pushViewController:orgListVC animated:YES];

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

