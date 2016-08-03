//
//  LevelButton.m
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelButton.h"

@interface LevelButton ()

@property (nonatomic, strong) UIImageView * lImageV;

@property (nonatomic, strong) UILabel * lTitleLab;

@end

@implementation LevelButton


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _lImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, frame.size.height - 6, frame.size.height - 6)];
        
        _lImageV.backgroundColor = [UIColor redColor];
        
        _lImageV.layer.cornerRadius = _lImageV.frame.size.width/2.0;
        _lImageV.layer.masksToBounds = YES;
        
        _lImageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_lImageV];
        
        _lTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lImageV.frame) + 5, 0, frame.size.width - CGRectGetMaxX(_lImageV.frame) - 10, frame.size.height)];
                
        _lTitleLab.font = [UIFont systemFontOfSize:14];
        
        _lTitleLab.textColor = [UIColor whiteColor];
        
        [self addSubview:_lTitleLab];
        
    }
    
    return self;
}

- (void)setLImage:(NSString *)lImage {
    
    _lImageV.image = [UIImage imageNamed:lImage];

}

- (void)setLTitle:(NSString *)lTitle {
    
    _lTitleLab.text = lTitle;

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
