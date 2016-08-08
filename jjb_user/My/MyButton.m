//
//  MyButton.m
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyButton.h"

@interface MyButton ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *detailLab;
//@property (nonatomic,strong) UIImageView *imageView_shop;
//@property (nonatomic,strong) UILabel *label_shop;
//@property (nonatomic,strong) UILabel *label_detail;

@end

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageV = [[UIImageView alloc] init];
        
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageV];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.equalTo(@16);
            make.top.equalTo(@10);
        }];
        
        _titleLab = [[UILabel alloc] init];
        
        _titleLab.textAlignment = NSTextAlignmentCenter;
        
        _titleLab.font = H1;
        
        [self addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(80, 20));
            make.top.equalTo(@14);
            make.left.equalTo(_imageV.mas_right).with.offset(8);
        }];
        
        _detailLab = [[UILabel alloc] init];
        
        _detailLab.textColor = COLOR_GRAY;
        
        _detailLab.textAlignment = NSTextAlignmentCenter;
        
        _detailLab.font = H3;
        
        [self addSubview:_detailLab];

        [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(80, 16));
            make.top.equalTo(_titleLab.mas_bottom).with.offset(4);
            make.centerX.equalTo(_titleLab.mas_centerX);
        }];
        
//        _imageView_shop = [[UIImageView alloc] init];
//        
//        _imageView_shop.contentMode = UIViewContentModeScaleAspectFit;
//
//        [self addSubview:_imageView_shop];
//        
//        [_imageView_shop mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.size.mas_equalTo(CGSizeMake(30, 30));
//            make.left.equalTo(@(Screen_Width/2.0+16));
//            make.top.equalTo(@10);
//        }];
//        
//        _label_shop = [[UILabel alloc] init];
//        
//        _label_shop.textAlignment = NSTextAlignmentCenter;
//        
//        _label_shop.font = H1;
//        
//        [self addSubview:_label_shop];
//        
//        [_label_shop mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.size.mas_equalTo(CGSizeMake(80, 20));
//            make.top.equalTo(@14);
//            make.left.equalTo(_imageView_shop.mas_right).with.offset(8);
//        }];
        
//        _label_detail = [[UILabel alloc] init];
//        
//        _label_detail.textColor = COLOR_GRAY;
//        
//        _label_detail.font = H3;
//        
//        _label_detail.textAlignment = NSTextAlignmentCenter;
//        
//        [self addSubview:_label_detail];
//        
//        [_label_detail mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.size.mas_equalTo(CGSizeMake(80, 16));
//            make.top.equalTo(_label_shop.mas_bottom).with.offset(4);
//            make.centerX.equalTo(_label_shop.mas_centerX);
//        }];
    }
    return self;
}

- (void)setBImage:(NSString *)bImage {
    
    _imageV.image = [UIImage imageNamed:bImage];
}

- (void)setBTitle:(NSString *)bTitle {
    
    _titleLab.text = bTitle;
}

- (void)setBDetail:(NSString *)bDetail {
    
    _detailLab.text = bDetail;
}
//
//- (void)setImageView_shop:(NSString *)imageView_shop {
//
//    _imageView_shop.image = [UIImage imageNamed:imageView_shop];
//}
//
//- (void)setLabel_shop:(NSString *)label_shop {
//
//    _label_shop.text = label_shop;
//}
//
//- (void)setLabel_detail:(NSString *)label_detail {
//
//    _label_detail.text = label_detail;
//}

@end
