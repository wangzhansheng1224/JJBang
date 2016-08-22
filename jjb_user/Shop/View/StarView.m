//
//  StarView.m
//  jjb_user
//
//  Created by Aimee on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StarView.h"

@implementation StarView

-(id) init{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

#pragma -
#pragma mark - drawRect

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    for (NSInteger i=0; i<self.score; i++) {
        
        UIImage *star=[UIImage imageNamed:@"star_solid"];
        [star drawAtPoint:CGPointMake(i*13,(rect.size.height-13)/2.0)];
        
    }

}
@end
