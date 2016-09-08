//
//  ActivityDetailCell.m
//  jjb_user
//
//  Created by Check on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityDetailCell.h"
#import "ActivityDetailKey.h"

@interface ActivityDetailCell ()

@property (nonatomic,strong) UIView *view_line;
//@property (nonatomic,strong) UIWebView *detailWebView;
@property (nonatomic,strong) UILabel *detailLabel;

@end

@implementation ActivityDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self addSubview:self.view_line];
        [self addSubview:self.detailLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView=self;
    
    [self.view_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
        make.top.mas_equalTo(superView.mas_top);
        make.height.mas_equalTo(@(10));
    }];

//    [self.detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left).offset(10);
//        make.right.mas_equalTo(superView.mas_right).offset(-10);
//        make.top.equalTo(self.view_line.mas_bottom);
//        make.height.equalTo(@(Screen_Height-380));
//    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.top.equalTo(self.view_line.mas_bottom);
        make.height.equalTo(@(Screen_Height-380));
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
//    [self.detailWebView loadHTMLString:data[kActivityDetailContent] baseURL:nil];
    [self.detailLabel setText:data[kActivityDetailContent]];
    CGSize size = [data[kActivityDetailContent] boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H3} context:nil].size;
    
    float height = size.height;
    
    if ([data[kActivityDetailContent] length] <= 0) {
        height = 0;
    }
    
    [_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.view_line.mas_bottom);
    }];
}



#pragma -
#pragma mark - getters and setters

-(UIView*) view_line{
    if (!_view_line) {
        _view_line=[[UIView alloc] init];
        _view_line.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _view_line;
}

//-(UIWebView*) detailWebView{
//    
//    if (!_detailWebView) {
//        _detailWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, Screen_Height-330, Screen_Width, Screen_Height)];
//        _detailWebView.backgroundColor=COLOR_WHITE;
//    }
//    return _detailWebView;
//}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = H3;
        _detailLabel.textColor = COLOR_GRAY;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

@end
