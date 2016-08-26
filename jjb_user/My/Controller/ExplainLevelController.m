//
//  ExplainLevelController.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//
//  等级说明
#import "ExplainLevelController.h"

@interface ExplainLevelController ()
@property(nonatomic,strong)UILabel * label;

@end

@implementation ExplainLevelController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"说明";
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self setSubViewsConstraints];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setSubViewsConstraints
{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
}

#pragma -
#pragma mark - getter and setter
-(UILabel *)label
{
    if (_label == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"敬起期待...";
        label.textColor = COLOR_DARK_GRAY;
        [label sizeToFit];
        [self.view addSubview:label];
        _label = label;
    }
    return _label;
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
