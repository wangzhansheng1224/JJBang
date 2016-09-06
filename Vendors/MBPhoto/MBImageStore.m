//
//  MBImageStore.m
//  jjb_user
//
//  Created by Maybe on 16/9/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBImageStore.h"

@interface MBImageStore ()
@property(nonatomic,strong)NSMutableDictionary * dictionary;

@end

@implementation MBImageStore
SingleM(MBImageStore)

#pragma -
#pragma mark - life cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
    //注册为低内存通知的观察者
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCaches:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }
    return self;
}

#pragma -
#pragma - private methods
-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.dictionary setObject:image forKey:key];
    //获取图片全路径
    NSString * path = [self imagePathForKey:key];
    //从图片中提取JPEG格式的数据，0.5f是图片压缩参数
    NSData * data = UIImageJPEGRepresentation(image, 0.5f);
    [data writeToFile:path atomically:YES];
}
-(UIImage *)imageForKey:(NSString *)key
{
    UIImage * image = [self.dictionary objectForKey:key];
    if (!image) {
        NSString * path = [self imagePathForKey:key];
        JJBLog(@"头像路径%@",path)
        image = [UIImage imageWithContentsOfFile:path];
        if (image) {
            [self.dictionary setObject:image forKey:key];
        }
        else
        {
            NSLog(@"图片不存在");
            [self imagePathForKey:key];
        }
    }
    return image;
}

-(NSString *)imagePathForKey:(NSString *)key
{
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}

-(void)clearCaches:(NSNotificationCenter *)nfc
{
    NSLog(@"摄像头报警了%lu",(unsigned long)self.dictionary.count);
    [self.dictionary removeAllObjects];
}
#pragma -
#pragma mark - getter and setter
-(NSMutableDictionary *)dictionary
{
    if (_dictionary ==nil) {
        _dictionary = [NSMutableDictionary dictionary];
    }
    return _dictionary;
}

@end
