//
//  LPWaterWaveView.h
//  AnchorProject
//
//  Created by 杭州任性智能科技有限公司 on 2019/2/27.
//  Copyright © 2019年 xys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPWaterWaveView : UIView
/** 振幅*/
@property (nonatomic, assign) CGFloat waveAmplitude;
/** 周期*/
@property (nonatomic, assign) CGFloat waveCycle;
/** 速度*/
@property (nonatomic, assign) CGFloat waveSpeed;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat wavePointY;
/** 波浪x位移*/
@property (nonatomic, assign) CGFloat waveOffsetX;
/** 波浪颜色*/
@property (nonatomic, strong) UIColor *waveColor;

- (instancetype)initWithFrame:(CGRect)frame;

/** 开始波浪动画 */
- (void)startLayerAnimation;

/** 停止波浪动画 */
- (void)stopLayerAnimation;

@end

NS_ASSUME_NONNULL_END
