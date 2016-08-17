//
//  MBScanButton.h
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ScanButtonBlock)(UIButton *);
@interface MBScanButton : UIButton

@property(nonatomic,copy)ScanButtonBlock block;
-(void)addScanViewControllerBlock:(ScanButtonBlock)block;
@end
