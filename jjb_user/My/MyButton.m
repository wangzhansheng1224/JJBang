//
//  MyButton.m
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyButton.h"

@interface MyButton ()

@property (nonatomic, strong) UILabel * titleLab;

@property (nonatomic, strong) UIImageView * imageV;

@property (nonatomic, strong) UILabel * detailLab;

@end

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        
        _titleLab.backgroundColor = [UIColor whiteColor];
        
        _titleLab.center = CGPointMake(self.center.x + 20, 35);
        
        _titleLab.textAlignment = NSTextAlignmentCenter;
        
        _titleLab.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:_titleLab];
        
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLab.frame) - 40, CGRectGetMinY(_titleLab.frame), 30, 30)];
        
        _imageV.backgroundColor = [UIColor purpleColor];
        
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageV];
        
        _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLab.frame), CGRectGetMaxY(_titleLab.frame), 100, frame.size.height/2.0)];
        
        _detailLab.backgroundColor = [UIColor magentaColor];
        
        _detailLab.textColor = [UIColor grayColor];
        
        _detailLab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_detailLab];

    }
    
    return self;
}



- (void)setBImage:(NSString *)bImage {
    
    _imageV.image = [UIImage imageNamed:bImage];
}

- (void)setBTitle:(NSString *)bTitle {
    
    _titleLab.text = bTitle;
}

-(void)setBDetail:(NSString *)bDetail {
    
    _detailLab.text = bDetail;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
