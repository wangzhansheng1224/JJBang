//
//  MBSaleCollectionView.m
//  jjb_user
//
//  Created by Maybe on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBSaleCollectionView.h"
#import "MBSaleCell.h"
@interface MBSaleCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
//所有的数据
@property(nonatomic,strong) NSMutableArray * listArray;
@property(nonatomic,strong) UICollectionViewFlowLayout * layout;
@property(nonatomic,strong)NSArray* data;
@end
@implementation MBSaleCollectionView

static NSString * const MBSaleCellIdentifier = @"MBSaleCellIdentifier";
static NSInteger const cols = 2;
static CGFloat const margin = 0;

#define cellWh ((Screen_Width -(cols -1) * margin)/cols)

#pragma 
#pragma mark - life cycle

-(instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize
{
 
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[MBSaleCell class] forCellWithReuseIdentifier:MBSaleCellIdentifier];
//        [self registerClass:[MBSaleCell class] forCellWithReuseIdentifier:MBSaleCellIdentifier];
    }
    return self;
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSArray *)data{
    self.data=data;
}

#pragma -
#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.data count];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MBSaleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MBSaleCellIdentifier forIndexPath:indexPath];
    [cell configWithData:self.data[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        JJBLog(@"点击1");
    }
    else
    {
        JJBLog(@"点击2");
    }
}



#pragma 
#pragma mark - getter and setter
-(NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(cellWh, cellWh);
        JJBLog(@"大小%@",NSStringFromCGSize(layout.itemSize));
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        _layout = layout;
    }
    return _layout;
}
@end
