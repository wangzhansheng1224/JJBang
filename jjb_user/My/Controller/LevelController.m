//
//  LevelController.m
//  jjb_user
//
//  Created by Aimee on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelController.h"

@interface LevelController ()

@property (nonatomic,strong) UIBarButtonItem *rightItem;

@end

@implementation LevelController
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"会员等级";
    self.navigationItem.rightBarButtonItem = self.rightItem;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - event respone
- (void)itemClick {

    
}

#pragma -
#pragma mark - getters and setters
- (UIBarButtonItem *)rightItem {

    if (!_rightItem) {
        
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStyleDone target:self action:@selector(itemClick)];
        _rightItem.tintColor = COLOR_WHITE;
    }
    return _rightItem;
}

@end
