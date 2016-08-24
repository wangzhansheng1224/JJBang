//
//  RHADScrollView.m
//  jjb_user
//
//  Created by Check on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "RHADScrollView.h"


#define  AD_Height  200

@interface RHADScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) int page;

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


#pragma mark - scrollView add images and play

- (void)play {
    
    if (self.arrPic.count > 0) {
        
        _pageControl.numberOfPages = self.arrPic.count;
        
    }
    
    if (self.adHeight > 0) {
        
        _pageControl.frame = CGRectMake(0, self.adHeight - 20, Screen_Width, 20);
        
        _scrollView.frame = CGRectMake(0, 0, Screen_Width, self.adHeight);

    }
    
    if (self.adHeight > 0 && self.arrPic.count > 0) {
        
        _scrollView.contentSize = CGSizeMake(self.arrPic.count * Screen_Width, self.adHeight);
    }
    
    [self scrollViewAddImages];
    
    [self removeTimer];
    
    if (self.arrPic.count > 0) {
        
        [self addTimer];
    }
    
}

- (void)scrollViewAddImages {
    
    NSLog(@"%@", self.arrPic);
    for (int i = 0; i < self.arrPic.count + 1; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * Screen_Width, 0, Screen_Width, self.adHeight)];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = 1000 + i;
        imageView.userInteractionEnabled = YES;
        if (i == self.arrPic.count) {
            
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.arrPic.firstObject] placeholderImage:[UIImage imageNamed:@"img_default"] options:SDWebImageCacheMemoryOnly];
        }else {
            
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.arrPic[i]] placeholderImage:[UIImage imageNamed:@"img_default"] options:SDWebImageCacheMemoryOnly];
        }
        
        if (i == 0 || i == self.arrPic.count) {
            
            imageView.backgroundColor = JJBRandomColor;
        }
        [_scrollView addSubview:imageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapADImageView:)];
        [imageView addGestureRecognizer:tap];
    }
    
}

#pragma mark - NSTimer
//添加
- (void)addTimer {
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(adAudioPlay) userInfo:nil repeats:YES];
        NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
        
        _page = 0;
    }
}
//移除
- (void)removeTimer {
    
    [_timer invalidate];
    
    _timer = nil;
}


#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = self.scrollView.contentOffset.x / Screen_Width;
    
    if (_scrollView.contentOffset.x == page * Screen_Width) {
        
        self.pageControl.currentPage = page;
    }
    
    if (_scrollView.contentOffset.x == self.arrPic.count * Screen_Width) {
        
        self.pageControl.currentPage = 0;
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
}
//暂停
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _timer.fireDate = [NSDate distantFuture];
    
}
//继续
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    _timer.fireDate = [NSDate distantPast];
    
}


#pragma mark -- timer action

- (void)adAudioPlay{
    
    _page++;
    [self.scrollView setContentOffset:CGPointMake(Screen_Width * _page, 0) animated:YES];
    if (_page == self.arrPic.count) {
        _page = 0;
    }
}

#pragma mark -- tap action

- (void)tapADImageView:(UITapGestureRecognizer *)tap{
    
    UIImageView * imageView = (UIImageView *)tap.view;
    NSInteger index = imageView.tag - 1000;
    
    if (index == self.arrPic.count) {
        
        index = 0;
    }
    if ([self.delegate respondsToSelector:@selector(tapImageIndex:)]) {
    
        [self.delegate tapImageIndex:index];
    }
}



#pragma mark - setter and getter

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, AD_Height)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(-Screen_Width / 2, AD_Height - 20, Screen_Width, 20)];
        _pageControl.numberOfPages = self.arrPic.count;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

- (void)setInvalidate:(BOOL)invalidate {
    
    if (invalidate) {
        
        [self removeTimer];
        
    }else {
        
        [self addTimer];
    }
}




@end
