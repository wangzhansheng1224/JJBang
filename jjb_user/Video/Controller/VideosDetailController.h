//
//  VideosDetailController.h
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "VideosDetailAPIManager.h"
#import "VideosDetailReformer.h"
@interface VideosDetailController : UIViewController<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UIWebViewDelegate>
@property (nonatomic,assign) NSInteger VideosID;
@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,strong) VideosDetailAPIManager *videosDetailAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> videoDetailReformer;
@property (nonatomic,strong) NSDictionary *videosDetailDictionary;
@property (nonatomic,copy) NSString *docUrl;
@end
