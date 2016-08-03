//
//  MBNewFeatureCollectionViewCell.h
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBNewFeatureCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImage * image;
-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
