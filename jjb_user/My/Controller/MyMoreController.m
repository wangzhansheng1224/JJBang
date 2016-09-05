//
//  MyMoreController.m
//  jjb_user
//
//  Created by Check on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyMoreController.h"
#import "MyMoreCell.h"
#import "ExplainLevelController.h"

@interface MyMoreController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *view_top;
@property (nonatomic,strong) UIImageView *imageView_icon;
@property (nonatomic,strong) UILabel *label_name;
@property (nonatomic,strong) NSMutableArray *titleArr;

@end

@implementation MyMoreController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_GRAY;
    self.navigationItem.title = @"关于我们";
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    [self.view_top addSubview:self.imageView_icon];
    [self.view_top addSubview:self.label_name];
    [self.view addSubview:self.view_top];
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.view_top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 242));
        make.top.left.equalTo(@0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height - 242));
        make.top.equalTo(self.view_top.mas_bottom).with.offset(0);
        make.left.equalTo(@0);
    }];
    
    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(95, 95));
        make.top.equalTo(@53);
        make.centerX.equalTo(_view_top.mas_centerX);
    }];
    
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.equalTo(self.imageView_icon.mas_bottom).with.offset(20);
        make.centerX.equalTo(_view_top.mas_centerX);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMoreCellIdentifier" forIndexPath:indexPath];
   
    if (indexPath.row < self.titleArr.count) {
        
        cell.title = self.titleArr[indexPath.row];
        cell.caches = [NSString stringWithFormat:@"%0.2fM",[self folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == 0) {
//        [QAlert showAlertWithController:self andTitle:@"检查更新" andMessage:@"当前为最新版本，不需要更新" andTime:2.0];
//    }
    [self clearData];
}

#pragma mark -- 清除缓存功能
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    //通过枚举遍历法遍历文件夹中的所有文件
    //创建枚举遍历器
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    //首先声明文件名称、文件大小
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        //得到当前遍历文件的路径
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        //调用封装好的获取单个文件大小的方法
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);//转换为多少M进行返回
}
#pragma mark 清除缓存大小 打印NSHomeDritiony前往Documents进行查看路径
- (void)clearCacheFromPath:(NSString*)path{
    //建立文件管理器
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        //如果文件路径存在 获取其中所有文件
        NSArray * fileArr = [manager subpathsAtPath:path];//找到所有子文件的路径，存到数组中。
        //首先需要转化为完整路径
        //直接删除所有子文件
        for (int i = 0; i < fileArr.count; i++) {
            NSString * fileName = fileArr[i];
            //完整路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:filePath error:nil];
        }
    }
}

- (void)clearData{
    
    UIAlertController * _alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [_alert addAction:action1];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //清除缓存
        [self clearCacheFromPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
        [_tableView reloadData];
    }];
    [_alert addAction:action2];
    
    [self presentViewController:_alert animated:YES completion:nil];
    
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyMoreCell class] forCellReuseIdentifier:@"MyMoreCellIdentifier"];
    }
    return _tableView;
}

- (UIView *)view_top {

    if (!_view_top) {
        
        _view_top = [[UIView alloc] init];
        _view_top.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _view_top;
}

- (UIImageView *)imageView_icon {

    if (!_imageView_icon) {
        
        _imageView_icon = [[UIImageView alloc] init];
        _imageView_icon.image = [UIImage imageNamed:@"login_select"];
    }
    return _imageView_icon;
}

- (UILabel *)label_name {

    if (!_label_name) {
        
        _label_name = [[UILabel alloc] init];
        _label_name.text = @"家家帮V1.0";
        _label_name.font = H1;
        _label_name.textColor = COLOR_ORANGE;
    }
    return _label_name;
}

- (NSMutableArray *)titleArr {

    if (!_titleArr) {
        
        _titleArr = [[NSMutableArray alloc] init];
        NSArray *array = @[@"清除缓存"];
        _titleArr = [NSMutableArray arrayWithArray:array];
    }
    return _titleArr;
}

@end
