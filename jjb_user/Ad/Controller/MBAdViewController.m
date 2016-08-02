//
//  MBAdViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

//
#import "MBAdViewController.h"
#import <UIImageView+WebCache.h>
#import "MBAdItem.h"
#import "BaseTabBarController.h"
#import <Masonry.h>

/**
 *  此界面为开始时的广告界面主控制器(暂时不用
)
 */
@interface MBAdViewController ()
/**
 *  广告模型
 */
@property(nonatomic,strong) MBAdItem * adItem;
/**
 *  背景
 */
@property(nonatomic,weak) UIImageView * adBgImageView;
//广告图片
@property(nonatomic,weak) UIImageView * adImageView;

@property(nonatomic,weak) UIButton * adButton;

@property(nonatomic,weak) NSTimer * timer;

@end

@implementation MBAdViewController

#pragma mark- 
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载背景图片
    [self setUpBgImageView];
    
    //加载广告数据
    [self loadData];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark --private method

-(void)loadData
{
    /**
     *  请求广告数据
     *
     *  @return
     */
    
}
-(void)timeChange
{
    static int time = 3;
    if (time == -1 ) {
        [self btnClick];
        return;
    }
    NSString * timeString = [NSString stringWithFormat:@"跳过(%d)",time];
    [self.adButton setTitle:timeString forState:UIControlStateNormal];
    
    time--;
}

-(void)setUpBgImageView
{
    if (iPhone6P) {
        self.adBgImageView.image= [UIImage imageNamed:@""];
    
    }else if (iPhone6)
    {
        self.adBgImageView.image = [UIImage imageNamed:@"guide_1"];
    }
    else if (iPhone5)
    {
        self.adBgImageView.image = [UIImage imageNamed:@""];
    }
    else if (iPhone4)
    {
        self.adBgImageView.image = [UIImage imageNamed:@""];
    }
    
}


//跳过广告，销毁当前界面
-(void)btnClick
{
    [_timer invalidate]; //销毁定时器
    
    //直接进入主界面
    BaseTabBarController * tabBarVC =  [[BaseTabBarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;

}
//打开网页
-(void)gotoVC
{
    NSURL * url = [NSURL URLWithString:_adItem.targetUrl];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark -
#pragma mark setter - getter

-(UIImageView *)adImageView
{
    if (_adImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = YES;
        _adImageView = imageView;
        [self.view insertSubview:imageView aboveSubview:self.adButton];
        
        //添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoVC)];
        [_adImageView addGestureRecognizer:tap];
        
    }
    return _adImageView;
}
-(UIImageView *)adBgImageView
{
    if (_adBgImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:imageView];
        _adBgImageView = imageView;
        
    }
    return _adBgImageView;
}
-(UIButton *)adButton
{
    if (_adButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"跳过(3)" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        _adButton = button;
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//        [button sizeToFit];
        [self.view addSubview: button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(30);
            make.right.equalTo(self.view.mas_right).offset(-30);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(70);
        }];
        
    }
    return _adButton;
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
