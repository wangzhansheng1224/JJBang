//
//  MbClassifyCollectionCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBClassifyCollectionCell.h"
#import "ShopClassifyCell.h"
#import "ShopClassifyModel.h"
@interface MBClassifyCollectionCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionViewFlowLayout * layout;
@property(nonatomic,assign) CGSize itemSize;
@property(nonatomic,strong) NSArray * imageArray;
@property(nonatomic,strong) NSArray * titleArray;

@end
@implementation MBClassifyCollectionCell


static NSString *const ID = @"cell";


static NSInteger const cols = 4;
static CGFloat const margin = 1;
static NSString * const cellID = @"cell";
#define  cellWH  ((Screen_Width - (cols - 1) * margin) / cols)
-(UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(cellWH, cellWH-10);
        JJBLog(@"%@",NSStringFromCGSize(layout.itemSize));
        layout.minimumInteritemSpacing = margin ;
        layout.minimumLineSpacing = margin;
        _layout = layout;
    }
    return _layout;
    
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        self.imageArray = imageArray;
        self.titleArray = titleArray;
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

    return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
     UIImageView * imageView = [[UIImageView alloc]initWithImage:self.imageArray[indexPath.row]];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 40, 20)];
    label.text = self.titleArray[indexPath.row];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
    return cell;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JJBLog(@"点击了%ld行，第%ld列",indexPath.section,indexPath.row);
}


//-(void)setClassifyModel:(ShopClassifyModel *)classifyModel
//{
//    
//}

@end

