//
//  MBNewFeatureController.m
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//
//新特性主控制器  引导页
#import "MBNewFeatureController.h"
#import "MBNewFeatureCollectionViewCell.h"

#define kMBGuidePageCount 3       //定义引导页数量
@interface MBNewFeatureController ()

@property(nonatomic,weak) UIImageView * guideView;
@property(nonatomic,assign) CGFloat offSetX;

@end

@implementation MBNewFeatureController


static NSString * const reuseIdentifier = @"cell";

#pragma mark - life cycle
-(instancetype)init
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [self initWithCollectionViewLayout:layout];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[MBNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self setUpGuideView];
}
/**
 *  控制器消失时移除掉ImageView
 *
 *  @param animated
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.guideView removeFromSuperview];
    
}

-(void)setUpGuideView
{
    UIImageView * guideView = [[UIImageView alloc]init];
    guideView.image = [UIImage imageNamed:@"guide_3"];
    guideView.centerX = self.view.centerX;
    self.guideView = guideView;
    [self.collectionView addSubview:guideView];
    
    
    

}
#pragma mark -
#pragma mark   UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat offsetGap = offsetX - self.offSetX;
    self.guideView.X += 2 * offsetGap;
    int page = offsetX / self.view.width +1 ;
    NSString * string = [NSString stringWithFormat:@"guide_%d",page];
    self.guideView.image = [UIImage imageNamed:string];
    self.offSetX = offsetX;
    
    
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kMBGuidePageCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MBNewFeatureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString * string = [NSString stringWithFormat:@"guide_%d",indexPath.row+1];
    cell.image = [UIImage imageNamed:string];

    [cell setIndexPath:indexPath count:kMBGuidePageCount];
    return cell;
}


#pragma mark - setter- geeter

@end
