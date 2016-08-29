//
//  VideosDetailController.h
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface VideosDetailController : UIViewController<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,assign) NSInteger VideosID;
@property (nonatomic,strong) UIWebView * webView;
@end
