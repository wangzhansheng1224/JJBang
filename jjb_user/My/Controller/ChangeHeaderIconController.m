//
//  ChangeHeaderIconController.m
//  jjb_user
//
//  Created by Check on 16/8/29.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ChangeHeaderIconController.h"
#import "changeMyInfoAPIManager.h"
#import "MBImageStore.h"
#import "OSSManager.h"
#import "ImgModel.h"
#import "PathHelper.h"
@interface ChangeHeaderIconController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIPopoverController * imagePickerPopver;
@property(nonatomic,strong) UIImageView * headImageView;
@property(nonatomic,strong) LDAPIBaseManager * changeHeaderAPIManager;

@end

@implementation ChangeHeaderIconController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    [self setUpNav];
    [self setChildViewContraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNav
{
    self.navigationItem.title = @"修改头像";

    UIBarButtonItem * chooseBtn = [UIBarButtonItem itmeWithNormalImage:[UIImage imageNamed:@"my_choose_header_button"] high:nil target:self action:@selector(chooseButtonClick:) norColor:nil highColor:nil title:nil];
    self.navigationItem.rightBarButtonItem = chooseBtn;
    
    
}
#pragma -
#pragma - SubViewContriaints
-(void)setChildViewContraints
{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(80);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
    }];
    
    
}


#pragma -
#pragma mark - buttonClick event
-(void)chooseButtonClick:(id)sender
{
    if ([self.imagePickerPopver isPopoverVisible]) {
        [self.imagePickerPopver dismissPopoverAnimated:YES];
        self.imagePickerPopver = nil;
        return;
    }
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    //允许编辑图片
    imagePicker.allowsEditing = YES;
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertView addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.imagePickerPopver = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
            self.imagePickerPopver.delegate = self;
            [self.imagePickerPopver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self presentViewController:imagePicker animated:YES
                             completion:nil];
        }
    }] ];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.imagePickerPopver = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
            self.imagePickerPopver.delegate = self;
            [self.imagePickerPopver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
    }]];
    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertView animated:YES
                     completion:nil];
    
}

#pragma -
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    [[MBImageStore shareMBImageStore] setImage:image forKey:@"MBStore"];
    self.headImageView.image = image;
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    NSData * editImageData = UIImageJPEGRepresentation(image, 0.8f);
   NSString * name =  [NSString stringWithFormat:@"%@.jpg",[[OSSManager shareInstance]currentTimeByJava]];
//    ImgModel * model = [[ImgModel alloc]init];
    [self.view makeToast:@"正在上传" duration:1.0f position:CSToastPositionCenter];
    [[OSSManager shareInstance]uploadFiles:@[image] withTargetSubPath:OSSMessagePath withBlock:^{
        [self.view makeToast:@"上传成功" duration:1.0f position:CSToastPositionCenter];
        [self.changeHeaderAPIManager loadData];
    }];
    
    
    
    if (self.imagePickerPopver) {
        [self.imagePickerPopver dismissPopoverAnimated:YES];
        self.imagePickerPopver = nil;
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    NSDictionary *resultData = [manager fetchDataWithReformer:nil];
    NSDictionary * dict  = resultData[@"data"];

    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
    
    return @{
             @"user_id" :@([UserModel currentUser].userID),
             @"photo":@""
             
             };
}

#pragma -
=======

#pragma -
#pragma mark - buttonClick event
-(void)chooseButtonClick:(id)sender
{
    if ([self.imagePickerPopver isPopoverVisible]) {
        [self.imagePickerPopver dismissPopoverAnimated:YES];
        self.imagePickerPopver = nil;
        return;
    }
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    //允许编辑图片
    imagePicker.allowsEditing = YES;
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertView addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.imagePickerPopver = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
            self.imagePickerPopver.delegate = self;
            [self.imagePickerPopver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self presentViewController:imagePicker animated:YES
                             completion:nil];
        }
    }] ];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.imagePickerPopver = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
            self.imagePickerPopver.delegate = self;
            [self.imagePickerPopver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
    }]];
    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertView animated:YES
                     completion:nil];
    
}

#pragma -
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    [[MBImageStore shareMBImageStore] setImage:image forKey:@"MBStore"];

    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    NSData * editImageData = UIImageJPEGRepresentation(image, 0.8f);
   NSString * name =  [NSString stringWithFormat:@"%@.jpg",[[OSSManager shareInstance]currentTimeByJava]];
    
    NSString* path = [[PathHelper cacheDirectoryPathWithName:MSG_Img_Dir_Name] stringByAppendingPathComponent:name];
    JJBLog(@"%@",path);
    [UserModel currentUser].photo = path;
    [UserModel save:[UserModel currentUser]];
    BOOL fg = [editImageData writeToFile:path atomically:YES];
    JJBLog(@"%@",fg);
    NSMutableArray * imageArray = [NSMutableArray array];
    ImgModel * model = [[ImgModel alloc]init];
    model.imgpath = path;
    model.status = NO;
    
    [imageArray addObject:model];

    
    [[OSSManager shareInstance]uploadFiles:imageArray withTargetSubPath:OSSHeaderPath withBlock:^{
        [self.changeHeaderAPIManager loadData];

    }];
    
    
    
    if (self.imagePickerPopver) {
        [self.imagePickerPopver dismissPopoverAnimated:YES];
        self.imagePickerPopver = nil;
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    NSDictionary *resultData = [manager fetchDataWithReformer:nil];
    NSDictionary * dict  = resultData[@"data"];

    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
    
    return @{
             @"user_id" :@([UserModel currentUser].userID),
             @"photo":@""
             
             };
}

#pragma -
>>>>>>> c8aa35c36bef1572d5562d4eff5af8378d0e8278
#pragma mark - getter and setter
-(UIImageView *)headImageView
{
    if (_headImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        
        imageView.image = [UIImage imageNamed:[UserModel currentUser].photo];
        [self.view addSubview:imageView];
        _headImageView = imageView;
    }
    return _headImageView;
}


@end
