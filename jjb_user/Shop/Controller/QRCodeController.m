//
//  QRCodeController.m
//  jjb_user    生成二维码
//
//  Created by Check on 16/9/14.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "QRCodeController.h"

@interface QRCodeController ()

@end

@implementation QRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的二维码";
    self.view.backgroundColor = COLOR_WHITE;
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 220, 220)];
    imageView.center = CGPointMake(self.view.centerX, self.view.centerY-32);
    [self.view addSubview:imageView];
//        [imageView release];
    imageView.image = [QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"%@",[UserModel currentUser].phone] imageSize:imageView.bounds.size.width];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
