//
//  ClerkDetailCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/26.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkDetailCell.h"
#import "TeacherTileView.h"
#import "ClerkKeys.h"
#import "TeacherKeys.h"

NSString * const kClerkTitle = @"ClerkTitle";
NSString * const kClerkContent = @"ClerkContent";
@interface ClerkDetailCell ()
@property(nonatomic,strong) UIView * lineView;
//@property(nonatomic,strong) TeacherTileView * noteView;
@property(nonatomic,strong) TeacherTileView * summaryView;

@end
@implementation ClerkDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=COLOR_LIGHT_GRAY;
//        [self addSubview:self.noteView];
        [self addSubview:self.summaryView];
    }
    return self;
}


-(void) layoutSubviews{
    UIView *superView=self;
    
//    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left);
//        make.top.mas_equalTo(superView.mas_top).offset(10);
//        make.height.mas_equalTo(@200);
//        make.right.mas_equalTo(superView.mas_right);
//    }];
    
    [self.summaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.height.mas_equalTo(@200);
        make.right.mas_equalTo(superView.mas_right);
    }];
    
    
}
#pragma -
#pragma mark - configWithData

- (void)configWithData:(NSDictionary *)data{
    
//    [self.noteView configWithData:@{
//                                    kClerkTitle:@"个人宣言",
//                                    kClerkContent:data[kTeacherNotes]
//                                    }];
    [self.summaryView configWithData:@{
                                       kClerkTitle:@"自我介绍",
                                       kClerkContent:data[kTeacherSummary]
                                       }];
}

#pragma -
#pragma mark - getter and setter

//-(TeacherTileView *) noteView
//{
//    if (!_noteView) {
//        _noteView=[[TeacherTileView alloc] init];
//    }
//    return _noteView;
//}
//
-(TeacherTileView *) summaryView
{
    if (!_summaryView) {
        _summaryView=[[TeacherTileView alloc] init];
    }
    return _summaryView;
}

@end
