//
//  LPTurntableModel.h
//  LotteryTest
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/4.
//  Copyright © 2019年 lisey_lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPTurntableModel : NSObject
@property (copy, nonatomic) NSString *name;             //奖品名称
@property (assign, nonatomic) NSInteger index;          //奖品的下标,唯一
@property (assign, nonatomic) CGFloat probability;      //概率
@property (assign, nonatomic) NSInteger minIndex;       //中奖最小值，包括
@property (assign, nonatomic) NSInteger maxIndex;       //中奖的最大值，不包括

@end

NS_ASSUME_NONNULL_END
