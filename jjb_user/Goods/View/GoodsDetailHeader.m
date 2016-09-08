//
//  GoodsDetailHeader.m
//  jjb_user
//
//  Created by Check on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsDetailHeader.h"
#import "GoodsDetailKey.h"
#import "RHADScrollView.h"

@interface GoodsDetailHeader()

//@property (nonatomic,strong) iCarousel *picImageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *salesLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSArray *imgArr;
@property (nonatomic,strong) RHADScrollView *adScrollView;

@end

@implementation GoodsDetailHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.adScrollView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.salesLabel];
        [self addSubview:self.lineView];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_adScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Width*2.0/3.0f));
        make.top.left.equalTo(@0);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.top.mas_equalTo(_adScrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(_salesLabel.mas_left);
    }];
    [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_adScrollView.mas_bottom).offset(10);
        make.right.equalTo(@-10);
        make.width.mas_equalTo(@100);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.right.left.equalTo(@0);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@10);
    }];

}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    
    [self.titleLabel setText:data[kGoodsDetailName]];
    self.imgArr=data[kGoodsDetailImages];
//    [self.picImageV reloadData];
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.imgArr.count; i++) {
        
        [mutArr addObject:[NSString stringWithFormat:@"%@%@",ImageServer,_imgArr[i][@"image"]]];
    }
    _adScrollView.arrPic = mutArr;
    [_adScrollView play];
}
//
//#pragma -
//#pragma mark - iCarouselDataSource
//
//- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
//    return [self.imgArr count];
//}
//- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
//    
//    if (view == nil)
//    {
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*2.0f/3.0f)];
//        NSURL *url=[NSURL initWithImageURL:self.imgArr[index][@"image"] Size:view.frame.size];
//        [((UIImageView *)view) sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];
//        view.contentMode = UIViewContentModeScaleAspectFit;
//        
//    }
//    
//    return view;
//}

#pragma -
#pragma mark - getters and setters
//- (iCarousel *)picImageV {
//
//    if (!_picImageV) {
//        _picImageV = [[iCarousel alloc] init];
//        _picImageV.dataSource=self;
//    }
//    return _picImageV;
//}
- (RHADScrollView *)adScrollView {

    if (!_adScrollView) {
        
        _adScrollView = [[RHADScrollView alloc] init];
        _adScrollView.adHeight = Screen_Width*2.0/3.0f;
        _adScrollView.delegate = self;
    }
    return _adScrollView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = H2;
        [_titleLabel sizeToFit];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)salesLabel {
    
    if (!_salesLabel) {
        
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"月销量1024";
        _salesLabel.textColor = COLOR_ORANGE;
        _salesLabel.font = H4;
        _salesLabel.textAlignment = NSTextAlignmentRight;
        [_salesLabel sizeToFit];
    }
    return _salesLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}

- (void)setInvalidate:(BOOL)invalidate {
    
    _adScrollView.invalidate = invalidate;
}

@end
