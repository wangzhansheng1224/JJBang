//
//  RHMenuView.m
//  RHProject
//
//  Created by Check on 16/4/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "RHMenuView.h"
#import "RHMenuButtonItem.h"
#import "RHHeader.h"

@interface RHMenuView  ()

@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)NSArray * menuTitles;

@property (nonatomic,copy)MyBlock block;


@end

@implementation RHMenuView

- (instancetype)initWithFrame:(CGRect)frame andMenuTitles:(NSArray *)titles andBlock:(MyBlock)block{
    
    _block = block;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _menuTitles = [NSMutableArray arrayWithArray:titles];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self createItem];
        
    }
    return self;
}


- (void)createItem{
    
    if (_menuTitles.count == 0) {
        return;
    }
    
    if (_menuTitles.count == 1) {
        
        RHMenuButtonItem * item = [[RHMenuButtonItem alloc] initWithFrame:CGRectMake(SCREEN_W/2-ITEM_WIDTH, 0, 2*ITEM_WIDTH, ITEM_HEIGHT) andTitle:_menuTitles[0] andNormalColor:NORMAL_COLOR andSelectColor:SELECT_COLOR];
        
        item.selected = YES;
        
        
        [self addSubview:item];
        
    }else if (SCREEN_W >= ITEM_WIDTH*_menuTitles.count) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        _scrollView.backgroundColor = COLOR_ORANGE;
        
        NSLog(@"%f",_scrollView.frame.size.height);
        [self addSubview:_scrollView];
        
        for (int i = 0; i < _menuTitles.count; i++) {
            
            RHMenuButtonItem * item = [[RHMenuButtonItem alloc] initWithFrame:CGRectMake((SCREEN_W/_menuTitles.count)*i, 0, SCREEN_W/_menuTitles.count, ITEM_HEIGHT) andTitle:_menuTitles[i] andNormalColor:NORMAL_COLOR andSelectColor:SELECT_COLOR];
            item.titleLabel.font = [UIFont systemFontOfSize:18];
            item.tag = 1000+i;
            
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_scrollView addSubview:item];
            
            if (i == 0) {
                
                item.selected = YES;
                
            }

        }
    }else {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        _scrollView.contentSize = CGSizeMake((ITEM_WIDTH+10)*_menuTitles.count+10, ITEM_HEIGHT);
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        for (int i = 0; i < _menuTitles.count; i++) {
            
            RHMenuButtonItem * item = [[RHMenuButtonItem alloc] initWithFrame:CGRectMake((ITEM_WIDTH+10)*i+10, 0, ITEM_WIDTH, ITEM_HEIGHT) andTitle:_menuTitles[i] andNormalColor:NORMAL_COLOR andSelectColor:SELECT_COLOR];
            
            item.tag = 1000+i;//用于获取item下标
            
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_scrollView addSubview:item];
            
            if (i == 0) {
                item.selected = YES;
            }
        }
    }
}


#pragma mark -- itemAction

- (void)itemClick:(RHMenuButtonItem *)item{
    
    //遍历ScrollView的子view找出RHMenuButtonItem 判断如果是当前点中的item 改变其selected属性为YES  否则改为NO
    for (UIView * view in _scrollView.subviews) {
        
        if ([view isKindOfClass:[RHMenuButtonItem class]]) {
            
            RHMenuButtonItem * menuItem = (RHMenuButtonItem *)view;
            
            if (menuItem == item) {
                
                menuItem.selected = YES;
                
            }else {
                
                menuItem.selected = NO;
            }
        }
    }
    
    self.block(item.tag-1000);
    
    if (SCREEN_W >= ITEM_WIDTH*_menuTitles.count) {
        
        return;
    }
    
    if (item.tag > 1000 && item.tag - 1000 < _menuTitles.count-1) {
        
        //使item居中
        [_scrollView setContentOffset:CGPointMake(item.center.x-SCREEN_W/2, 0) animated:YES];
    }
}


#pragma mark --item自动切换

- (void)changeSelectItemWithIndex:(NSInteger)index{
    
    RHMenuButtonItem * item = [self viewWithTag:1000+index];
    
    for (UIView * view in _scrollView.subviews) {
        
        if ([view isKindOfClass:[RHMenuButtonItem class]]) {
            
            RHMenuButtonItem * menuItem = (RHMenuButtonItem *)view;
            
            if (menuItem == item) {
                
                menuItem.selected = YES;
            }else {
                menuItem.selected = NO;
            }
        }
    }
    
    if (SCREEN_W >= ITEM_WIDTH*_menuTitles.count) {
        
        return;
    }
    
    if (item.tag > 1000 && item.tag-1000 < _menuTitles.count-1) {
        
        [_scrollView setContentOffset:CGPointMake(item.center.x-SCREEN_W/2, 0) animated:YES];
        
    }
    
}


#pragma mark -- 重写属性set方法  实现item自动切换

- (void)setSelectIndex:(NSInteger)selectIndex{
    
    RHMenuButtonItem * item = [self viewWithTag:1000+selectIndex];
    
    for (UIView * view in _scrollView.subviews) {
        
        if ([view isKindOfClass:[RHMenuButtonItem class]]) {
            
            RHMenuButtonItem * itemH = (RHMenuButtonItem *)view;
            
            if (itemH == item) {
                
                itemH.selected = YES;
            }else {
                
                itemH.selected = NO;
            }
        }
    }
    
    if (SCREEN_W >= ITEM_WIDTH*_menuTitles.count) {
        return;
    }
    
    if (item.tag > 1000 && item.tag-1000 < _menuTitles.count-1) {
        
        //item居中
        [_scrollView setContentOffset:CGPointMake(item.center.x-SCREEN_W/2, 0) animated:YES];
        
    }
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
