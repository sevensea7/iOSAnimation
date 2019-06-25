//
//  LPTurntableView.h
//  LotteryTest
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/4.
//  Copyright © 2019年 lisey_lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPTurntableModel;

@protocol LPTurntableViewDelegate <NSObject>

- (void)showResultOfTurntablePointer:(LPTurntableModel *)turntable;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LPTurntableView : UIView
@property (nonatomic, assign) NSInteger indexValue; // 转盘下标
@property (nonatomic, weak) id<LPTurntableViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
