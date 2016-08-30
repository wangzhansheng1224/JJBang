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

@property (nonatomic, assign) NSInteger page;

@end


@implementation RHADScrollView

#pragma mark - rewrite init

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _page = 1;
        
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
    
    if (self.arrPic.count > 1) {
        
        _pageControl.numberOfPages = self.arrPic.count;
        
    }else {
    
        _pageControl.numberOfPages = 0;
    }
    
    if (self.adHeight > 0) {
        
        _pageControl.frame = CGRectMake(0, self.adHeight - 20, Screen_Width, 20);
        
        _scrollView.frame = CGRectMake(0, 0, Screen_Width, self.adHeight);

    }
    
    if (self.adHeight > 0 && self.arrPic.count > 0) {
        
        _scrollView.contentSize = CGSizeMake((self.arrPic.count + 2) * Screen_Width, self.adHeight);
        
        _scrollView.contentOffset = CGPointMake(Screen_Width, 0);
    }
    
    [self scrollViewAddImages];
    
    [self removeTimer];
    
    if (self.arrPic.count > 1) {
        
        [self addTimer];
    }
    
}

- (void)scrollViewAddImages {
    
    NSLog(@"%@", self.arrPic);
    for (int i = 0; i < self.arrPic.count + 2; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * Screen_Width, 0, Screen_Width, self.adHeight)];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = 1000 + i;
        imageView.userInteractionEnabled = YES;
        if (i == 0) {
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.arrPic.lastObject] placeholderImage:[UIImage imageNamed:@"img_default"] options:SDWebImageCacheMemoryOnly];
            
        }else if (i == self.arrPic.count + 1) {
            
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.arrPic.firstObject] placeholderImage:[UIImage imageNamed:@"img_default"] options:SDWebImageCacheMemoryOnly];
        }else {
            
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.arrPic[i-1]] placeholderImage:[UIImage imageNamed:@"img_default"] options:SDWebImageCacheMemoryOnly];
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
        
    }
}
//移除
- (void)removeTimer {
    
    if (!_timer) {
        
        [_timer invalidate];
        
        _timer = nil;
    }
}


#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = (scrollView.contentOffset.x) / Screen_Width;
    
    _page = page;
    
    if (page == self.arrPic.count + 1) {
        
        self.pageControl.currentPage = 0;
        
        self.scrollView.contentOffset = CGPointMake(Screen_Width, 0);
        
    }else if (scrollView.contentOffset.x == 0) {
        
        self.scrollView.contentOffset = CGPointMake(self.arrPic.count * Screen_Width, 0);
        
        self.pageControl.currentPage = self.arrPic.count - 1;
        
    }else {
        
        self.pageControl.currentPage = page - 1;
    }
    
}
//暂停
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
//    _timer.fireDate = [NSDate distantFuture];
    [self removeTimer];
    
}
//继续
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
//    _timer.fireDate = [NSDate distantPast];
    [self addTimer];
    
}


#pragma mark -- timer action

- (void)adAudioPlay{
    
    _page++;
    [self.scrollView setContentOffset:CGPointMake(Screen_Width * _page, 0) animated:YES];
    
    if (_page == self.arrPic.count + 1) {
        _page = 1;
    }
}

#pragma mark -- tap action

- (void)tapADImageView:(UITapGestureRecognizer *)tap{
    
    UIImageView * imageView = (UIImageView *)tap.view;
    NSInteger index = imageView.tag - 1000;
    
    if (index == self.arrPic.count + 1) {
        
        index = 1;
    }else if (index == 0) {
        
        index = 1;
    }
    if ([self.delegate respondsToSelector:@selector(tapImageIndex:)]) {
    
        [self.delegate tapImageIndex:index - 1];
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
