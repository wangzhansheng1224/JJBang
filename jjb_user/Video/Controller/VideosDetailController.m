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
#define VIDEOURL @"http://115.29.221.199:82/live/live-detail?code="
//live/live-detail-new?code=1F0345APAL00070
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频详情";
    [self.view addSubview:self.webView];
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.videosDetailAPIManager loadData];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark webViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view makeToast:nil duration:0.50f position:CSToastPositionCenter];
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
#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[VideosDetailAPIManager class]]) {
    _videosDetailDictionary = [manager fetchDataWithReformer:self.videoDetailReformer];
        NSDictionary *dict = _videosDetailDictionary[@"data"];
        if (dict) {
            _docUrl = [NSString stringWithFormat:@"%@%@",VIDEOURL,dict[@"video_code"]];
        }
        
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_docUrl]]];
        
    }
    
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
                @"id":@(self.VideosID)
//                @"user_id":@([UserModel currentUser].userID)
            };

}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}


- (UIWebView *)webView {
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
//        _docUrl = @"https://www.baidu.com";
        _webView.allowsInlineMediaPlayback = YES;
        _webView.mediaPlaybackRequiresUserAction = NO;
        
    }
    return _webView;
}

- (LDAPIBaseManager *)videosDetailAPIManager {
    if (_videosDetailAPIManager == nil) {
        _videosDetailAPIManager = [VideosDetailAPIManager  sharedInstance];
        _videosDetailAPIManager.delegate=self;
        _videosDetailAPIManager.paramSource=self;
    }
    return _videosDetailAPIManager;
}
-(id<ReformerProtocol>)OrderDetailReformer
{
    if (_videoDetailReformer == nil) {
        _videoDetailReformer = [[VideosDetailReformer alloc]init];
    }
    return _videoDetailReformer;
}
-(NSDictionary *)videosDetailDictionary
{
    if (_videosDetailDictionary == nil) {
        _videosDetailDictionary = [NSDictionary dictionary];
        
    }
    return _videosDetailDictionary;
}







@end