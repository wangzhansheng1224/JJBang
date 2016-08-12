//
//  IssueController.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "IssueController.h"

@interface IssueController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIBarButtonItem *item_issue;
@property (nonatomic,strong) UIButton *btn_video;
@property (nonatomic,strong) UIButton *btn_face;
@property (nonatomic,strong) UIButton *btn_more;
@property (nonatomic,strong) UIButton *btn_camera;
@property (nonatomic,strong) UILabel *label_placehold;

@end

@implementation IssueController
#pragma
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.rightBarButtonItem = self.issueItem;
 
    [self.view addSubview:self.btn_camera];
    [self.view addSubview:self.btn_video];
    [self.view addSubview:self.btn_face];
    [self.view addSubview:self.btn_more];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.label_placehold];
    [self.view bringSubviewToFront:self.btn_camera];
    [self.view bringSubviewToFront:self.btn_face];
    [self.view bringSubviewToFront:self.btn_video];
    [self.view bringSubviewToFront:self.btn_more];
    [self layoutPageSubviews];
}

#pragma -
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    
    self.textView.text = @"";
    self.label_placehold.text = @"此时此地，想和大家分享什么";
}

#pragma
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.equalTo(@283);
        make.left.right.equalTo(@0);
    }];
    
    [self.label_placehold mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(@7);
        make.height.equalTo(@24);
        make.right.equalTo(@-7);
    }];

    [self.btn_camera mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(62, 62));
        make.left.equalTo(@24);
        make.bottom.equalTo(self.textView.mas_bottom).with.offset(-24);
    }];

    [self.btn_video mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.btn_camera.mas_right).with.offset(10);
        make.bottom.equalTo(self.textView.mas_bottom).with.offset(-24);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    
    [self.btn_face mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.btn_video.mas_right).with.offset(10);
        make.bottom.equalTo(self.textView.mas_bottom).with.offset(-24);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    
    [self.btn_more mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.btn_face.mas_right).with.offset(10);
        make.bottom.equalTo(self.textView.mas_bottom).with.offset(-24);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
}

#pragma 
#pragma mark - custom methods

#pragma
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma
#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma
#pragma mark - alert delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

#pragma
#pragma mark - pickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
//    _view_pic.image = savedImage;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.textView.text = textView.text;
    if (textView.text.length == 0) {
        self.label_placehold.text = @"此时此地，想和大家分享什么";
    }else{
        self.label_placehold.text = @"";
    } 
}

#pragma
#pragma mark - event response
- (void)itemClick {
    
    NSLog(@"发布成功！");
}

- (void)btn_cameraClick {
    //访问相机
    UIActionSheet *sheet;
    // 判断是否支持相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
}



- (void)btn_videoClick {
    
    NSLog(@"视频");
}

- (void)btn_faceClick {
    
    NSLog(@"表情");
}

- (void)btn_moreClick {
    
    NSLog(@"更多");
}


#pragma
#pragma mark - getter and setter
- (UITextView *)textView {

    if (!_textView) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        _textView = [[UITextView alloc] init];
        _textView.font = H2;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _textView.delegate = self;
    }
    return _textView;
}

- (UIBarButtonItem *)issueItem {
    
    if (!_item_issue) {
        
        _item_issue = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
        [_item_issue setTintColor:COLOR_WHITE];
    }
    return _item_issue;
}

- (UIButton *)btn_camera {

    if (!_btn_camera) {
        
        _btn_camera = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn_camera.frame = CGRectMake(100, 100, 50, 50);
        _btn_camera.backgroundColor = [UIColor darkGrayColor];
        [_btn_camera setTitle:@"图片" forState:UIControlStateNormal];
        [_btn_camera addTarget:self action:@selector(btn_cameraClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_camera;
}

- (UIButton *)btn_video {
    
    if (!_btn_video) {
        
        _btn_video = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn_video.backgroundColor = [UIColor darkGrayColor];
        [_btn_video setTitle:@"视频" forState:UIControlStateNormal];
        [_btn_video addTarget:self action:@selector(btn_videoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_video;
}

- (UIButton *)btn_face {
    
    if (!_btn_face) {
        
        _btn_face = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn_face.backgroundColor = [UIColor darkGrayColor];
        [_btn_face setTitle:@"表情" forState:UIControlStateNormal];
        [_btn_face addTarget:self action:@selector(btn_faceClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_face;
}

- (UIButton *)btn_more {
    
    if (!_btn_more) {
        
        _btn_more = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn_more.backgroundColor = [UIColor darkGrayColor];
        [_btn_more setTitle:@"更多" forState:UIControlStateNormal];
        [_btn_more addTarget:self action:@selector(btn_moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_more;
}

- (UILabel *)label_placehold {

    if (!_label_placehold) {
        
        _label_placehold = [[UILabel alloc] init];
        _label_placehold.text = @"此时此地，想和大家分享什么";
        _label_placehold.backgroundColor = [UIColor clearColor];
        _label_placehold.enabled = NO;
        _label_placehold.font = H2;
        [_label_placehold sizeToFit];
    }
    return _label_placehold;
}


@end
