//
//  TileView.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TileView.h"
#import "TileViewItem.h"

#define TileViewItem_Margin 10
#define TileViewItem_Cols 4
#define TileViewItem_Width  ((Screen_Width - (TileViewItem_Cols + 2) * TileViewItem_Margin) / TileViewItem_Cols)
@interface TileView ()

@end

@implementation TileView


-(void) addItems:(NSArray *)items
{
    [self.dataArray addObjectsFromArray:items];
}

-(void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    if ([self.dataArray count]==0) {
//       UIImage *publish=[UIImage imageNamed:@"btn_publish"];
//        [publish drawAtPoint:CGPointMake(10, 10)];
//    }
    
    for (NSInteger i=0; i<[self.dataArray count]; i++) {
        NSInteger col=i%4;
        NSInteger row=i/4;
        UIImage *publish=[UIImage imageNamed:@"btn_publish"];
        TileViewItem *item=self.dataArray[i];
        NSLog(@"%f,%f,%f",TileViewItem_Width,publish.size.width,publish.size.height);
        item.frame=CGRectMake(col*TileViewItem_Width+10, row*TileViewItem_Width+10, TileViewItem_Width, TileViewItem_Width);
        [self addSubview:item];
        
       // [publish drawAtPoint:CGPointMake(col*TileViewItem_Width+10, row*TileViewItem_Width+10)];
    }
}

#pragma mark -
#pragma mark getter and setter
-(NSArray*) dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
}
@end
