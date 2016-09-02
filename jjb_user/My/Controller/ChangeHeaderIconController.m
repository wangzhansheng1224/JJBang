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
@property(nonatomic,strong)NSMutableArray * imageArray;

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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImage * image = [[MBImageStore shareMBImageStore]imageForKey:@"MBStore"];
    self.headImageView.image = image;
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

    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    NSData * editImageData = UIImageJPEGRepresentation(image, 0.8f);
   NSString * name =  [NSString stringWithFormat:@"%@.jpg",[[OSSManager shareInstance]currentTimeByJava]];
    
    NSString* path = [[PathHelper cacheDirectoryPathWithName:MSG_Img_Dir_Name] stringByAppendingPathComponent:name];
    JJBLog(@"%@",path);
    [UserModel currentUser].photo = name;
    JJBLog(@"生成的图片%@",name);
   
    [UserModel save:[UserModel currentUser]];
    [editImageData writeToFile:path atomically:YES];

    self.imageArray = [NSMutableArray array];
    ImgModel * model = [[ImgModel alloc]init];
    model.imgpath = path;
    model.status = NO;
    
    [self.imageArray addObject:model];

    [self.view makeToast:@"正在上传" duration:1.0f position:CSToastPositionCenter];
    [[OSSManager shareInstance]uploadFiles:self.imageArray withTargetSubPath:OSSHeaderPath withBlock:^{
       
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
    BOOL dict  = resultData[@"data"];
    if (dict) {
        [self.view makeToast:@"修改头像成功" duration:1.0f position:CSToastPositionCenter];
    }else
    {
       [self.view makeToast:@"修改头像失败" duration:1.0f position:CSToastPositionCenter];
    }
    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
[self.view makeToast:@"修改头像失败" duration:1.0f position:CSToastPositionCenter];
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
    NSMutableString * imgString = [NSMutableString string];
    for (ImgModel * img in self.imageArray) {
        [imgString appendFormat:@"%@@",img.imagename];
    }
    [imgString deleteCharactersInRange:NSMakeRange(imgString.length-1, 1)];
    [UserModel currentUser].photo = imgString;
    [UserModel save:[UserModel currentUser]];
    JJBLog(@"%@",imgString);
    
    return @{
             @"user_id" :@([UserModel currentUser].userID),
             @"photo":imgString
             
             };
}

#pragma -
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
-(LDAPIBaseManager *)changeHeaderAPIManager
{
    if (_changeHeaderAPIManager == nil) {
        _changeHeaderAPIManager = [changeMyInfoAPIManager sharedInstance];
        _changeHeaderAPIManager.delegate = self;
        _changeHeaderAPIManager.paramSource = self;
    }
    return _changeHeaderAPIManager;
}

@end
