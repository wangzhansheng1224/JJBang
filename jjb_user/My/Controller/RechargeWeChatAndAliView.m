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

@end
@implementation RechargeWeChatAndAliView

-(instancetype)initWithItems:(NSArray *)items{
    self=[super init];
    if (self) {
        self.userInteractionEnabled = YES;
        for (NSInteger i=0; i<[items count]; i++) {
            RechargeWeChatAndAliCell *cell=(RechargeWeChatAndAliCell*)items[i];
            cell.frame=CGRectMake(0, i*60, Screen_Width, 60);
            [self addSubview:cell];
            
        }
    }
    return self;

}



@end
