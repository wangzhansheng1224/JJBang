//
//  CourseController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseController.h"

/**
 *  课程控制器
 */
@implementation CourseController

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
    self.navigationItem.title = @"课程";
}



@end
