//
//  MySettingCell.m
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MySettingCell.h"

@interface MySettingCell ()

@property (nonatomic, strong) UILabel * lab_title;

@property (nonatomic, strong) UILabel * lab_content;

@end

@implementation MySettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setCell];
    }
    return self;
}

- (void)setCell {
    
    _lab_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, self.frame.size.height)];
    
    [self.contentView addSubview:_lab_title];
    
    
    _lab_content = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width - 140, 0, 80, self.frame.size.height)];
    
    _lab_content.textColor = [UIColor grayColor];
    
    _lab_content.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_lab_content];
}

- (void)setTitle:(NSString *)title {
    
    _lab_title.text = title;
}

- (void)setContent:(NSString *)content {
    
    _lab_content.text = content;
}



@end
