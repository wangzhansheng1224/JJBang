//
//  RHADScrollView.m
//  jjb_user
//
//  Created by Check on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "RHADScrollView.h"


#define  AD_Height  173

@interface RHADScrollView () <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong) NSArray * arr_pic;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) NSTimer * timer;

@end


@implementation RHADScrollView


#pragma mark - rewrite init

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _page = 0;
        [self addSubviews];
    }
    return self;
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}


#pragma mark - scrollView add images

- (void)scrollViewAddImages {
    
    for (int i = 0; i < _arr_pic.count + 1; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i * Screen_Width, 0, Screen_Height, AD_Height)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, AD_Height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = 1000 + i;
        imageView.userInteractionEnabled = YES;
        if (i == _arr_pic.count) {
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:_arr_pic[0]] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        }else {
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:_arr_pic[i]] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        }
        
        imageView.backgroundColor = JJBRandomColor;
        
        if (i == 0 || i == _arr_pic.count) {
            
            imageView.backgroundColor = [UIColor greenColor];
        }
        [view addSubview:imageView];
        [_scrollView addSubview:view];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapADImageView:)];
        [imageView addGestureRecognizer:tap];
    }
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = self.scrollView.contentOffset.x / Screen_Width;
    
    if (_scrollView.contentOffset.x == page * Screen_Width) {
        
        self.pageControl.currentPage = page;
    }
    
    if (_scrollView.contentOffset.x == _arr_pic.count * Screen_Width) {
        
        self.pageControl.currentPage = 0;
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _timer.fireDate = [NSDate distantFuture];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    _timer.fireDate = [NSDate distantPast];
    
}


#pragma mark -- timer action

- (void)adAudioPlay{
    
    _page++;
    [self.scrollView setContentOffset:CGPointMake(Screen_Width * _page, 0) animated:YES];
    if (_page == _arr_pic.count) {
        _page = 0;
    }
}

#pragma mark -- tap action

- (void)tapADImageView:(UITapGestureRecognizer *)tap{
    
    UIImageView * imageView = (UIImageView *)tap.view;
    NSInteger index = imageView.tag - 1000;
    
    if ([self.delegate respondsToSelector:@selector(tapImageIndex:)]) {
    
        [self.delegate tapImageIndex:index];
    }
}



#pragma mark - setter and getter

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, AD_Height)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(_arr_pic.count * Screen_Width, AD_Height);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(- Screen_Width/2, AD_Height - 20, Screen_Width, 20)];
        _pageControl.numberOfPages = self.arr_pic.count;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

- (NSTimer *)timer {
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(adAudioPlay) userInfo:nil repeats:YES];
        NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];

        _page = 0;
    }
    return _timer;
}

- (void)setArrPic:(NSArray *)arrPic {
    
    self.arr_pic = arrPic;
    _pageControl.numberOfPages = arrPic.count;
    [self scrollViewAddImages];
}

- (void)setInvalidate:(BOOL)invalidate {
    
    if (invalidate) {
        
        [_timer invalidate];
        
        _timer = nil;
        
    }else {
        
        self.timer;
    }
}




@end
