//
//  RHMenuButtonItem.m
//  jjb_user
//
//  Created by Check on 16/4/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "RHMenuButtonItem.h"

@interface RHMenuButtonItem ()

{
    UILabel * _line;
}

@end


@implementation RHMenuButtonItem


- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        
        [self setTitleColor:selectColor forState:UIControlStateSelected];
        
        _line = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-2, frame.size.width, 2)];
        
        NSLog(@"%f",frame.size.width);
        _line.backgroundColor = selectColor;
        
        _line.hidden = YES;
        
        [self addSubview:_line];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    _line.hidden = !selected;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
