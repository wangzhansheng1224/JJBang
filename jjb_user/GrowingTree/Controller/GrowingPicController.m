//
//  GrowingPicController.m
//  jjb_user
//
//  Created by Check on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingPicController.h"

@interface GrowingPicController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UITapGestureRecognizer *tapGR;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation GrowingPicController

#pragma -
#pragma - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self photosBrowser];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self.scrollView addGestureRecognizer:self.tapGR];
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.scrollView.contentOffset = CGPointMake(self.index * Screen_Width, 0);
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(@0);
    }];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(@-30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma -
#pragma mark - photosBrowser
- (void)photosBrowser {
    
    for (int i = 0; i < self.photos.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * Screen_Width, 0, Screen_Width, Screen_Height)];
        
        imageView.backgroundColor = JJBRandomColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        
        //        NSDictionary * dic = self.photos[i];
        //
        //        NSString * urlStr = dic[@"image_path"];
        //
        //        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        
        [self.scrollView addSubview:imageView];
    }
}

#pragma -
#pragma - event respone
- (void)tapGR:(UITapGestureRecognizer *)click {

    CATransition *transition = [CATransition animation];
    transition.type = @"push";
    transition.subtype = @"fromCenter";
    transition.duration = 1;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / (self.view.frame.size.width-10) ;
    UIPageControl *pageC = (UIPageControl *)[self.view viewWithTag:2016];
    pageC.currentPage = pageIndex;
}

#pragma -
#pragma mark - getters
- (UITapGestureRecognizer *)tapGR {

    if (!_tapGR) {
        
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    }
    return _tapGR;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        self.scrollView.contentSize = CGSizeMake(self.photos.count * Screen_Width, Screen_Height);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {

    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, self.view.frame.size.width- 200, 10)];
        _pageControl.numberOfPages = self.photos.count;
        _pageControl.currentPageIndicatorTintColor = COLOR_WHITE;
        _pageControl.pageIndicatorTintColor = COLOR_DARK_GRAY;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.tag = 2016;
    }
    return _pageControl;
}


@end
