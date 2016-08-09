//
//  MBStarTeacherCollectionView.m
//  jjb_user
//
//  Created by Maybe on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBStarTeacherCollectionView.h"
#import "MBStarTeacherCell.h"

static NSString * const MBStarTeacherCellIdentifier = @"MBStarTeacherCellIdentifier";
static NSInteger const cols = 2;
static CGFloat const margin = 1.0;
#define cellWh ((Screen_Width -(cols -1) * margin)/cols)

@interface MBStarTeacherCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) NSMutableArray * starStudentArray;
@property(nonatomic,strong) UICollectionViewFlowLayout * layout;
@end
@implementation MBStarTeacherCollectionView

#pragma 
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[MBStarTeacherCell class] forCellWithReuseIdentifier:MBStarTeacherCellIdentifier];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.starStudentArray.count;
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MBStarTeacherCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MBStarTeacherCellIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        JJBLog(@"%s",__func__);
        
    }else if (indexPath.row == 1)
    {
        JJBLog(@"%s",__func__);
    }
    
}
#pragma 
#pragma mark - getter and setter
-(NSMutableArray *)starStudentArray
{
    if (_starStudentArray) {
        _starStudentArray = [NSMutableArray array];
    }
    return _starStudentArray;
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
