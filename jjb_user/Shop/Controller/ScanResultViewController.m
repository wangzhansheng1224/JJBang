//
//  ScanResultViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ScanResultViewController.h"
/**
 *  扫描结果页面
 */
@interface ScanResultViewController ()
@property(nonatomic,strong) UILabel * labelText;   //扫描结果

@end

@implementation ScanResultViewController

#pragma mark
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewConstraint];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"扫描结果";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark
#pragma mark -private methods

-(void)addChildViewConstraint
{
    [self.labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
    }];
}


#pragma mark 
#pragma mark - getter and setter
-(UILabel *)labelText
{
    if (_labelText == nil) {
        UILabel * label = [[UILabel alloc]init];
        
        label.text = _strScan;
        [label addSubview:self.view];
        _labelText = label;
        
    }
    return _labelText;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
