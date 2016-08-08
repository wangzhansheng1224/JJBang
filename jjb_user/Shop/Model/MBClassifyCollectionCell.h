//
//  MbClassifyCollectionCell.h
//  jjb_user
//
//  Created by Maybe on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ShopClassifyModel;
@class ShopClassifyModel
@interface MBClassifyCollectionCell : UICollectionView



-(instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize imageArray:(NSArray*)imageArray titleArray:(NSArray *)titleArray;
//@property(nonatomic,strong)ShopClassifyModel * classifyModel;
//@property(nonatomic,strong)ShopClassifyModel * classifyModel;
//@property(nonatomic,strong)ShopClassifyModel * classifyModel;
@property(nonatomic,strong) ShopClassifyModel * shopModel;

@end
