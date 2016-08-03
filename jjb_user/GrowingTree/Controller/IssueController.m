//
//  IssueController.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "IssueController.h"
#import <Masonry.h>

@interface IssueController ()<UITextViewDelegate>

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) UIBarButtonItem *issueItem;

@end

@implementation IssueController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = JJBRandomColor;
    self.navigationItem.rightBarButtonItem = self.issueItem;
    [self.view addSubview:self.textView];
    [self configMasonry];
   
}

#pragma mark -- Masonry
- (void)configMasonry {

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.height.equalTo(@300);
        make.left.right.equalTo(@0);
    }];
}

#pragma mark -- event response
- (void)itemClick {

    NSLog(@"发布成功！");
}


#pragma mark -- UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -- getter and setter
- (UITextView *)textView {

    if (!_textView) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont fontWithName:@"Arial" size:20.0];
        _textView.text = @"此时此地，想和大家分享什么";
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

        _textView.delegate = self;
    }
    return _textView;
}

- (UIBarButtonItem *)issueItem {
    
    if (!_issueItem) {
        
        _issueItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    }
    return _issueItem;
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
