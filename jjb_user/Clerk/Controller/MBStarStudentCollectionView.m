//
//  MBStarStudentCollectionView.m
//  jjb_user
//
//  Created by Maybe on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBStarStudentCollectionView.h"
#import "MBStarStudentCell.h"
#import "ShopIndexKeys.h"


static NSString * const MBStarStudentCellIdentifier = @"MBStarStudentCellIdentifier";
static NSInteger const cols = 2;
static CGFloat const margin = 1.0;
#define cellWh ((Screen_Width -(cols -1) * margin)/cols)


@interface MBStarStudentCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) NSMutableArray * starStudentsArray;
@property(nonatomic,strong) UICollectionViewFlowLayout * layout;
@property(nonatomic,strong) NSArray * data;
@end
@implementation MBStarStudentCollectionView

#pragma 
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[MBStarStudentCell class] forCellWithReuseIdentifier:MBStarStudentCellIdentifier];
    }
    return self;
}


#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSArray *)data{
    self.data=data;
}


#pragma mark 
#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.starStudentsArray;
    return [self.data count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MBStarStudentCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MBStarStudentCellIdentifier forIndexPath:indexPath];
    [cell configWithData:self.data[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic=self.data[indexPath.row];
    
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_StudentDetail:@{@"studentID":dataDic[kShopIndexSdtListID]}];
    [navController pushViewController:controller animated:YES];
    
}

#pragma 
#pragma mark - getter and setter
-(NSMutableArray *)starStudentsArray
{
    if (_starStudentsArray ==nil) {
        _starStudentsArray = [NSMutableArray array];
        
    }
    return _starStudentsArray;
}
-(UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(cellWh, cellWh);
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        _layout = layout;
    }
    return _layout;
}
@end
