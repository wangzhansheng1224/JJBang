//
//  RechargeWeChatAndAliView.m
//  jjb_user
//
//  Created by Maybe on 16/8/11.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "RechargeWeChatAndAliView.h"
#import "RechargeWeChatAndAliCell.h"

@interface RechargeWeChatAndAliView ()
@property (nonatomic,strong) RechargeWeChatAndAliCell *currentCell;
@end
@implementation RechargeWeChatAndAliView

-(instancetype)initWithItems:(NSArray *)items{
    self=[super init];
    if (self) {
        self.userInteractionEnabled = YES;
        for (NSInteger i=0; i<[items count]; i++) {
            RechargeWeChatAndAliCell * cell=(RechargeWeChatAndAliCell*)items[i];
            if (i == 0) {
                cell.choiceButton.selected = YES;
                cell.choiceButton.tag = 100;
                self.currentCell=cell;
            }
                [cell selectButton:^(RechargeWeChatAndAliCell *sender) {
                 self.selectIndex=cell.tag;
                 if (self.currentCell) {
                     self.currentCell.choiceButton.selected=NO;
                 }
                
                 self.currentCell=cell;
                if (cell.choiceButton.tag == 100) {
                        cell.choiceButton.selected = NO;
                    }
                
                    self.currentCell.choiceButton.selected = YES;
             }];
            cell.frame=CGRectMake(0, i*60, Screen_Width, 60);

            [self addSubview:cell];
            
        }
    }
    return self;

}



@end
