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

- (void)configWithNoteData:(NSDictionary *)data{
    
    [self.summaryView configWithData:@{
                                       kClerkDetailTitle:@"自我介绍",
                                       kClerkDetailNotes:data[kClerkDetailNotes]
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
