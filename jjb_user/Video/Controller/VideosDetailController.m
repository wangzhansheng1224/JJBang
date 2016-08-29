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


@interface VideosDetailController ()

@property (nonatomic,strong) VideosDetailHeader *headerView;
@property (nonatomic,strong)

@end

@implementation VideosDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频详情";
    [self.view addSubview:self.webView];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
    [self.detailAPIManager loadData];
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
    
}

- (UIWebView *)webView {
    
    if (!_webView) {
        
        _webView = [[WKWebView alloc] init];
        UIWebView * webview = [[UIWebView alloc] initWithFrame:self.view.frame];
        NSString *docUrl = @"http://192.168.6.21/ttt/video.html";
        webview.allowsInlineMediaPlayback = YES;
        webview.mediaPlaybackRequiresUserAction = NO;
       [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:docUrl]]];

        
    }
    return _webView;
}









@end