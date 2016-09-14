//
//  ClerkDetailCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/26.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkDetailCell.h"
#import "ClerkDetailTileView.h"
#import "ClerkDetailKeys.h"
#import "ClerkDetailCell.h"

@interface ClerkDetailCell ()
@property(nonatomic,strong) UIView * lineView;
@property(nonatomic,strong) ClerkDetailTileView * summaryView;

@end
@implementation ClerkDetailCell
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=COLOR_LIGHT_GRAY;
        [self addSubview:self.summaryView];
    }
    return self;
}


-(void) layoutSubviews{
    UIView *superView=self;
    //介绍
    [self.summaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.height.mas_equalTo(@200);
        make.right.mas_equalTo(superView.mas_right);
    }];
    
    
}
#pragma -
#pragma mark - configWithData

- (void)configWithNoteData:(NSDictionary *)data block:(backHeightBlock)backBlock{
    
    JJBLog(@"自我介绍==%@",data[kClerkDetailNotes]);

    [self.summaryView configWithCellData:@{
                                       kClerkDetailTitle:@"自我介绍",
                                       kClerkDetailNotes:data[kClerkDetailNotes]
                                       }];
    CGSize size = [data[kClerkDetailNotes] boundingRectWithSize:CGSizeMake(Screen_Width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H4} context:nil].size;
    
    float height = size.height;
    if ([data[kClerkDetailNotes] length] <= 0) {
        
        height = 50;
        backBlock(height);
    }
    backBlock(height+50.f);
    [self.summaryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@(height+50.f));
        make.right.mas_equalTo(self.mas_right);
    }];

}

#pragma -
#pragma mark - getter and setter

-(ClerkDetailTileView *) summaryView
{
    if (!_summaryView) {
        _summaryView=[[ClerkDetailTileView alloc] init];
    }
    return _summaryView;
}

@end
