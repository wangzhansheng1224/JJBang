//
//  TeacherDetailCell.m
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherDetailCell.h"
#import "TeacherTileView.h"
#import "TeacherKeys.h"

@interface TeacherDetailCell()
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) TeacherTileView *noteView;
@property (nonatomic,strong) TeacherTileView *summaryView;
@end
@implementation TeacherDetailCell


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=COLOR_LIGHT_GRAY;
        [self addSubview:self.noteView];
        [self addSubview:self.summaryView];
        
    }
    return self;
}


-(void) layoutSubviews{
    UIView *superView=self;
    
    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.height.mas_equalTo(@200);
        make.right.mas_equalTo(superView.mas_right);
    }];
    
    [self.summaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(_noteView.mas_bottom).offset(10);
//        make.height.mas_equalTo(@200);
        make.right.mas_equalTo(superView.mas_right);
    }];
    

}
#pragma -
#pragma mark - configWithData

- (void)configWithData:(NSDictionary *)data block:(backHeightBlock)backBlock
{
    
    [self.noteView configWithData:@{
                                    kTeacherTitle:@"个人宣言",
                                    kTeacherContent:data[kTeacherNotes]
                                    }];
    [self.summaryView configWithData:@{
                                    kTeacherTitle:@"自我介绍",
                                    kTeacherContent:data[kTeacherSummary]
                                    }];
    
    CGSize size = [data[kTeacherSummary] boundingRectWithSize:CGSizeMake(Screen_Width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H3} context:nil].size;
    
    float height = size.height;
    JJBLog(@"返回的%f",height);
    if ([data[kTeacherSummary] length] <= 0) {
        
        height = 0;
        backBlock(height);
    }
    backBlock(height);
    [self.summaryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(_noteView.mas_bottom).offset(10);
        make.height.mas_equalTo(@(height));
        make.right.mas_equalTo(self.mas_right);
    }];

}

#pragma -
#pragma mark - getter and setter

-(TeacherTileView *) noteView
{
    if (!_noteView) {
        _noteView=[[TeacherTileView alloc] init];
            }
    return _noteView;
}

-(TeacherTileView *) summaryView
{
    if (!_summaryView) {
        _summaryView=[[TeacherTileView alloc] init];

    }
    return _summaryView;
}

@end
