//
//  TileViewItem.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TileViewItem.h"

@interface TileViewItem()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation TileViewItem

-(instancetype) init{
    self=[super init];
    if (self) {
        self.frame=CGRectMake(0, 0, 78, 78);
        [self addSubview:self.imageView];
    }
    return self;
}

-(void) setTileViewImage:(UIImage*) image{
    [self.imageView setImage:image];
}

-(UIImage*) getTileViewImage
{
    return self.imageView.image;
}

-(UIImageView*) imageView{
    
    if (_imageView) {
        _imageView=[[UIImageView alloc] init];
        _imageView.frame=self.bounds;
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
