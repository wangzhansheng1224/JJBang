//
//  ErrorController.m
//  jjb_user
//
//  Created by Aimee on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ErrorController.h"


@interface ErrorController ()

@property(nonatomic,strong) UIImageView * iView_Error;

@end
@implementation ErrorController
#pragma mark
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"错误提示";
    [self.view setBackgroundColor:COLOR_WHITE];
    [self.view addSubview:self.iView_Error];
    [self layoutPageSubviews];
    
}

#pragma mark
#pragma mark - layoutPageSubviews
-(void)layoutPageSubviews
{
        UIView *superView=self.view;
    [self.iView_Error mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.centerY.mas_equalTo(superView.mas_centerY);
        
    }];
}

#pragma mark
#pragma mark - getter and setter
-(UIImageView *)iView_Error
{
    if (_iView_Error == nil) {
        _iView_Error=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_empty"]];
    }
    return _iView_Error;
}
@end
