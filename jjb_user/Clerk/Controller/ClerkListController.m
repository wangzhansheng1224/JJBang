//
//  ClerkListController.m
//  jjb_user
//
//  Created by Maybe on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkListController.h"
/**
 *  店员列表界面
 */
@interface ClerkListController ()

@end

@implementation ClerkListController


#pragma
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}



#pragma
#pragma mark - private methods
-(void)setupNav
{
    self.navigationItem.title = @"所有店员";
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
