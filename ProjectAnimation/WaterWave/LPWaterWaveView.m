//
//  LPWaterWaveView.m
//  AnchorProject
//
//  Created by 杭州任性智能科技有限公司 on 2019/2/27.
//  Copyright © 2019年 xys. All rights reserved.
//

#import "LPWaterWaveView.h"

@interface LPWaterWaveView ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *shapeLayer1;
@property (nonatomic, strong) CAShapeLayer *shapeLayer2;
@property (nonatomic, strong) CAShapeLayer *shapeLayer3;

@end


@implementation LPWaterWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        [self ConfigParams];
        [self startWave];
    }
    return self;
}

#pragma mark 配置参数
- (void)ConfigParams {
    if (!_waveWidth) {
        _waveWidth = self.frame.size.width + 10;
    }
    if (!_waveHeight) {
        _waveHeight = 20;
    }
    //  背景色
    if (!_waveColor) {
        _waveColor = [UIColor clearColor];
    }
    
    if (!_waveSpeed) {
        _waveSpeed = 2.5f;
    }
    if (!_waveOffsetX) {
        _waveOffsetX = 10;
    }
    if (!_wavePointY) {
        _wavePointY = 50;
    }
    if (!_waveAmplitude) {
        _waveAmplitude = 20;
    }
    if (!_waveCycle) {
        _waveCycle =  1.29 * M_PI / _waveWidth;
    }
}

#pragma mark 加载layer ，绑定runloop 帧刷新
- (void)startWave {
    
    [self.layer addSublayer:self.shapeLayer1];
    [self.layer addSublayer:self.shapeLayer2];
    [self.layer addSublayer:self.shapeLayer3];
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - 帧动画
- (void)getCurrentWave {
    _waveOffsetX += _waveSpeed;
    
    [self changeFirstWaveLayerPath];
    [self changeSecondWaveLayerPath];
    [self changeThirdWaveLayerPath];
}

#pragma mark - 路径
- (void)changeFirstWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, -5, y);
    for (float x = 0.0f; x <= _waveWidth; x ++) {
        y = _waveAmplitude * 1.6 * sin((250 / _waveWidth) * (x * M_PI / 180) - _waveOffsetX * M_PI / 270) + _wavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    _shapeLayer1.path = path;
    CGPathRelease(path);
}

- (void)changeSecondWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, -5, y);
    for (float x = 0.0f; x <= _waveWidth; x ++) {
        y = _waveAmplitude * 1.6 * sin((250 / _waveWidth) * (x * M_PI / 180) - _waveOffsetX * M_PI / 225) + _wavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    _shapeLayer2.path = path;
    CGPathRelease(path);
}

- (void)changeThirdWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, -5, y);
    for (float x = 0.0f; x <= _waveWidth; x ++) {
        y = _waveAmplitude * 1.6 * sin((250 / _waveWidth) * (x * M_PI / 180) - _waveOffsetX * M_PI / 180) + _wavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    _shapeLayer3.path = path;
    CGPathRelease(path);
}

#pragma mark - Getter
- (CAShapeLayer *)shapeLayer1 {
    if (!_shapeLayer1) {
        _shapeLayer1 = [CAShapeLayer layer];
        _shapeLayer1.frame = CGRectMake(-5, -5, self.bounds.size.width, self.bounds.size.height);
        _shapeLayer1.strokeColor = COLOR_16F(0x000000, 0.3).CGColor;
        _shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer1;
}

- (CAShapeLayer *)shapeLayer2 {
    
    if (!_shapeLayer2) {
        _shapeLayer2 = [CAShapeLayer layer];
        _shapeLayer2.frame =  CGRectMake(-5, -5, self.bounds.size.width, self.bounds.size.height);
        _shapeLayer2.strokeColor = COLOR_16F(0x000000, 0.3).CGColor;
        _shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer2;
}

- (CAShapeLayer *)shapeLayer3 {
    if (!_shapeLayer3) {
        _shapeLayer3 = [CAShapeLayer layer];
        _shapeLayer3.frame =  CGRectMake(-5, -5, self.bounds.size.width, self.bounds.size.height);
        _shapeLayer3.strokeColor = COLOR_16F(0xCF4CE4, 1).CGColor;
        _shapeLayer3.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer3;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    }
    return _displayLink;
}



/** 开始波浪动画 */
- (void)startLayerAnimation {
    [self startWave];
}

/** 停止波浪动画 */
- (void)stopLayerAnimation {
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)dealloc {
    [_displayLink invalidate];
    _displayLink = nil;
}

@end
