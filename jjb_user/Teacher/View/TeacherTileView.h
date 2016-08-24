//
//  TeacherTileView.h
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kTeacherTitle;
extern NSString *const kTeacherContent;

@interface TeacherTileView : UIView
- (void)configWithData:(NSDictionary *)data;
@end
