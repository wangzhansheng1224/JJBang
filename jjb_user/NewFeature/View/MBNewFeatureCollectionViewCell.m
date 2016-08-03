//
//  MBNewFeatureCollectionViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBNewFeatureCollectionViewCell.h"
#import "BaseTabBarController.h"
@interface MBNewFeatureCollectionViewCell ()
@property(nonatomic,weak) UIImageView * imageView;
@property(nonatomic,weak) UIButton * startButton;

@end
@implementation MBNewFeatureCollectionViewCell
-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count -1 ) {
        self.startButton.hidden = NO;
    }
    else
    {
        self.startButton.hidden = YES;
    }
}
-(void)start
{
    BaseTabBarController * tabBar = [[BaseTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}
#pragma mark -
#pragma mark - setter和getter
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        JJBLog(@"%@",NSStringFromCGRect(self.bounds));
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}
-(UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tab_activity_normal"] forState:UIControlStateNormal];
        [btn setTitle:@"开始体验" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.center = CGPointMake(self.width * 0.5, self.height * 0.9);
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        _startButton = btn;
        [self addSubview:_startButton];

    }
    return _startButton;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}
@end
