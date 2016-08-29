//
//  VideosDetailController.m
//  jjb_user
//
//  Created by Aimee on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "VideosDetailController.h"
#import "VideosDetailCell.h"
#import "VideosDetailReformer.h"


@implementation VideosDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频详情";
    [self.view addSubview:self.webView];
    [self layoutPageSubviews];
//    [self.detailAPIManager loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height - 64));
            make.top.equalTo(@0);
            make.left.equalTo(@0);
        }];
    
}

- (UIWebView *)webView {
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] init];
        NSString *docUrl = @"http://192.168.6.21/ttt/video.html";
        _webView.allowsInlineMediaPlayback = YES;
        _webView.mediaPlaybackRequiresUserAction = NO;
       [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:docUrl]]];

        
    }
    return _webView;
}









@end