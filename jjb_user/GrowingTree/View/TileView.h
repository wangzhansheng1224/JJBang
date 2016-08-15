//
//  TileView.h
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileView : UIView
@property (nonatomic,strong) NSMutableArray* dataArray;
-(void) addItems:(NSArray*) items;
@end
