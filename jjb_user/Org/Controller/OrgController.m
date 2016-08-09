//
//  OrgController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrgController.h"
/**
 *  机构控制器
 */
@implementation OrgController

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
    self.navigationItem.title = @"机构";
}
@end
