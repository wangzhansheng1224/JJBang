//
//  IssueController.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "IssueController.h"
#import "PublishAlbumTopView.h"
#import "UzysAssetsPickerController.h"
#import "PathHelper.h"
#import "OSSManager.h"
#import "ImgModel.h"
#import "GrowingTreePublishAPIManager.h"


@interface IssueController ()<UITextViewDelegate,UzysAssetsPickerControllerDelegate,PublishAlbumTopViewDelegate,LDAPIManagerParamSourceDelegate,LDAPIManagerApiCallBackDelegate>

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIBarButtonItem *item_issue;
@property (nonatomic,strong) UILabel *label_placehold;
@property (nonatomic,strong) PublishAlbumTopView *tileView;
@property(nonatomic,strong)     NSMutableArray* arrImgs;
@property (nonatomic,strong) LDAPIBaseManager *publishAPIManager;
@end

@implementation IssueController
#pragma
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发布成长";
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.rightBarButtonItem = self.issueItem;
 
    [self.view addSubview:self.textView];
    [self.view addSubview:self.label_placehold];
    [self.view addSubview:self.tileView];
    [self.view bringSubviewToFront:self.tileView];
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
#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length == 0) {
        self.label_placehold.text = @"此时此地，想和大家分享什么";
    }else{
        self.label_placehold.text = @"";
    } 
}

- (void)textViewDidBeginEditing:(UITextView*)textView
{
    _textView = textView;
}

#pragma
#pragma mark - event response
- (void)itemClick {
    
    if (_tileView.dataList.count == 0) {
        [self.view makeToast:@"请选择要上传的图片！"];
        return;
    }
    if (_textView.text.length == 0) {
        [self.view makeToast:@"请选择输入内容！"];
        return;
    }
    _arrImgs = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [_tileView.dataList count]; i++) {
        ALAsset* asset = _tileView.dataList[i];
        UIImage* tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        NSData* editImageData = UIImageJPEGRepresentation(tempImg, 0.8f);
        
        NSString* name = [NSString stringWithFormat:@"%@.jpg", [[OSSManager shareInstance] currentTimeByJava]];
        
        NSString* path = [[PathHelper cacheDirectoryPathWithName:MSG_Img_Dir_Name] stringByAppendingPathComponent:name];
        [editImageData writeToFile:path atomically:YES];
        ImgModel* model = [[ImgModel alloc] init];
        model.sort = i;
        model.imgpath = path;
        model.status=NO;
        [_arrImgs addObject:model];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[OSSManager shareInstance] uploadFiles:_arrImgs withTargetSubPath:OSSMessagePath withBlock:^() {
        [self.publishAPIManager loadData];
    }];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSDictionary *resultDic = [manager fetchDataWithReformer:nil];
    if ([resultDic[@"code"] isEqualToString:@"200"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
    NSDictionary *resultDic = [manager fetchDataWithReformer:nil];
    [self.view makeToast:resultDic[@"message"]];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    
    NSMutableString *imgStrings=[[NSMutableString alloc] initWithCapacity:0] ;
    for (ImgModel* img in _arrImgs) {
        [imgStrings appendFormat:@"%@@",img.imagename];
    }
    [imgStrings deleteCharactersInRange:NSMakeRange(imgStrings.length-1,1)];
    
    return @{
             @"user_id":@"2",
             @"from_user_id":@"4",
             @"shop_id":@"1",
             @"content":_textView.text,
             @"longitude":@"40.69847032728747",
             @"latitude":@"40.69847032728747",
             @"address":@"北京",
             @"images":imgStrings
             };
}

#pragma mark -
#pragma mark PublishAlbumTopViewDelegate

- (void)showPickImgs:(NSMutableArray*)dataList
{
#if 0
    UzysAppearanceConfig *appearanceConfig = [[UzysAppearanceConfig alloc] init];
    appearanceConfig.finishSelectionButtonColor = [UIColor blueColor];
    appearanceConfig.assetsGroupSelectedImageName = @"checker.png";
    appearanceConfig.cellSpacing = 1.0f;
    appearanceConfig.assetsCountInALine = 5;
    [UzysAssetsPickerController setUpAppearanceConfig:appearanceConfig];
#endif
    UzysAssetsPickerController* picker = [[UzysAssetsPickerController alloc] init];
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 9 - dataList.count;
    picker.delegate = self;
    
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         
                     }];
}

#pragma mark -
#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [_tileView addImgUrls:assets];
    }
}

#pragma
#pragma mark - getter and setter
- (UITextView *)textView {

    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 140)];
        _textView.font = H2;
        _textView.textAlignment = NSTextAlignmentLeft;
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



- (UILabel *)label_placehold {

    if (!_label_placehold) {
        
        _label_placehold = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
        _label_placehold.text = @"此时此地，想和大家分享什么";
        _label_placehold.backgroundColor = [UIColor clearColor];
        _label_placehold.enabled = NO;
        _label_placehold.font = H2;
        [_label_placehold sizeToFit];
    }
    return _label_placehold;
}

-(PublishAlbumTopView *)tileView
{
    if (!_tileView) {
          _tileView = [[PublishAlbumTopView alloc] initWithFrame:CGRectMake(0, 150, Screen_Width, 3*PublishImageTileHeight + 40)];
        _tileView.imageMaxCount=9;
        _tileView.delegate = self;
        [_tileView setViewDefault];
    }
    return _tileView;
}

-(LDAPIBaseManager *)publishAPIManager{
    if (!_publishAPIManager) {
        _publishAPIManager=[[GrowingTreePublishAPIManager alloc] init];
        _publishAPIManager.paramSource=self;
        _publishAPIManager.delegate=self;
    }
   return _publishAPIManager;
}
@end
