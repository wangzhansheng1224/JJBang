//
//  MyCommentController.m
//  jjb_user    意见与反馈
//
//  Created by Check on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyCommentController.h"

@interface MyCommentController ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UITextView *commentTV;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextView *phoneTV;
@property (nonatomic,strong) UIBarButtonItem *rightItem;

@end

@implementation MyCommentController
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"意见与反馈";
    [self.view addSubview:self.commentTV];
    [self.view addSubview:self.commentLabel];
    [self.view addSubview:self.phoneTV];
    [self.view addSubview:self.phoneLabel];

    [self layoutPageSubviews];
}

#pragma - 
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_commentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(Screen_Width*2.0/3.0f));
    }];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(@8);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
    }];
    [_phoneTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_commentTV.mas_bottom).with.offset(10);
        make.left.right.equalTo(@0);
        make.height.equalTo(@50);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneTV.mas_top).with.offset(8);
        make.left.right.equalTo(@8);
        make.height.equalTo(@30);
    }];
}

#pragma -
#pragma mark - event respone
- (void)rightItemClick {

    
}

#pragma
#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.commentTV resignFirstResponder];
        [self.phoneTV resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger index = textView.tag;
    

    if (index == 200) {
   
        if (self.commentTV.text.length == 0) {
            self.commentLabel.text = @"请留下您宝贵意见和建议，我们将努力改进";
        }else{
            self.commentLabel.text = @"";        }
    }
    if (index == 300){
        if (self.phoneTV.text.length == 0) {
            self.phoneLabel.text = @"请留下手机号，已便我们回复您";
        }else {
            self.phoneLabel.text = @"";
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView*)textView
{
    self.commentTV = textView;
    self.phoneTV = textView;
}

#pragma -
#pragma mark - getters and setters
- (UILabel *)commentLabel {

    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
        _commentLabel.text = @"请留下您宝贵意见和建议，我们将努力改进";
        _commentLabel.backgroundColor = [UIColor clearColor];
        _commentLabel.enabled = NO;
        _commentLabel.font = H2;
        [_commentLabel sizeToFit];
    }
    return _commentLabel;
}

- (UITextView *)commentTV {

    if (!_commentTV) {
        
        _commentTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 140)];
        _commentTV.font = H2;
        _commentTV.textAlignment = NSTextAlignmentLeft;
        _commentTV.delegate = self;
        _commentTV.tag = 200;
    }
    return _commentTV;
}

- (UILabel *)phoneLabel {

    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
        _phoneLabel.text = @"请留下手机号，已便我们回复您";
        _phoneLabel.backgroundColor = [UIColor clearColor];
        _phoneLabel.enabled = NO;
        _phoneLabel.font = H2;
        [_phoneLabel sizeToFit];
    }
    return _phoneLabel;
}

- (UITextView *)phoneTV {

    
    if (!_phoneTV) {
        
        _phoneTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 140)];
        _phoneTV.font = H2;
        _phoneTV.textAlignment = NSTextAlignmentLeft;
        _phoneTV.delegate = self;
        _phoneTV.tag = 300;
    }
    return _phoneTV;
}

- (UIBarButtonItem *)rightItem {

    if (!_rightItem) {
        
        _rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_comment"] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
        _rightItem.tintColor = COLOR_WHITE;
    }
    return _rightItem;
}

@end
