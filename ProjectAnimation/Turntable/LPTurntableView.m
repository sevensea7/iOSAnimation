//
//  LPTurntableView.m
//  LotteryTest
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/4.
//  Copyright © 2019年 lisey_lee. All rights reserved.
//

#import "LPTurntableView.h"
#import "LPTurntableModel.h"
#import "MJExtension.h"

@interface LPTurntableView () <CAAnimationDelegate>
@property (nonatomic, strong) UIImageView *turnBackView; // 转盘
@property (nonatomic, strong) UIButton *pointerBtn; // 指针图
@property (nonatomic, strong) NSMutableArray *dataArr; // 数据
@property (nonatomic, strong) LPTurntableModel *selectedModel; // 选中的model0
@property (nonatomic, assign) NSInteger turntableCount; // 转盘范围
@property (nonatomic, assign) CGFloat angle; // 角度

@end

@implementation LPTurntableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setupView];
    }
    return self;
}

- (void)initData {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TurntableData" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.dataArr = [LPTurntableModel mj_objectArrayWithKeyValuesArray:array];
    // 设置整个demo的区间长度
    self.turntableCount = 10000;
    NSInteger min = -625;
    
    // 设置中奖区间
    for (int i = 0; i < self.dataArr.count; i++) {
        LPTurntableModel *model = self.dataArr[i];
        model.minIndex = min;
        model.maxIndex = model.minIndex + model.probability * self.turntableCount;
        min = model.maxIndex;
    }
}

- (void)setupView {
    
    _turnBackView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, self.bounds.size.width - 40, self.bounds.size.width - 40)];
    _turnBackView.image = [UIImage imageNamed:@"wheel_bg"];
    [self addSubview:_turnBackView];
    
    _pointerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pointerBtn.frame = CGRectMake(0, 0, 100, 100);
    _pointerBtn.center = _turnBackView.center;
    _pointerBtn.adjustsImageWhenDisabled = NO;
    _pointerBtn.adjustsImageWhenHighlighted = NO;
    [_pointerBtn setBackgroundImage:[UIImage imageNamed:@"wheel_needle"] forState:UIControlStateNormal];
    [_pointerBtn addTarget:self action:@selector(startPointButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pointerBtn];
}

- (void)startPointButton:(UIButton *)sender {
    NSInteger index = 0;
    if (!self.indexValue) {
        index = arc4random() % _turntableCount - 625;
    } else {
        index = self.indexValue * _turntableCount / 8 - 625;
    }
    
    for (LPTurntableModel *model in self.dataArr) {
        if (index >= model.minIndex && index < model.maxIndex) {
            _selectedModel = model;
            // 显示动画
            [self showAnimationWithSelectedModel:model];
            NSLog(@"%ld---%@", model.index, model.name);
            break;
        }
    }
}

#pragma mark - 动画

/**
 显示动画，转盘转动
 */
- (void)showAnimationWithSelectedModel:(LPTurntableModel *)model {
    self.pointerBtn.enabled = NO;
    
    NSInteger count = self.dataArr.count;
    NSInteger current = 5;
    _angle = model.index * 2 * M_PI / count + current * 2 * M_PI;
    
    CABasicAnimation *layer = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    layer.fromValue = 0;
    layer.toValue = @(_angle);
    layer.duration = _angle / (3 * M_PI);
    layer.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    layer.fillMode = kCAFillModeForwards;
    layer.removedOnCompletion = NO;
    layer.repeatCount = 0;
    layer.delegate = self;
    
    [self.turnBackView.layer addAnimation:layer forKey:nil];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // 显示中奖弹窗
    [self showAlertView];
    self.pointerBtn.enabled = YES;
}

// 代理
- (void)showAlertView {
    if (_delegate && [_delegate respondsToSelector:@selector(showResultOfTurntablePointer:)]) {
        [_delegate showResultOfTurntablePointer:_selectedModel];
    }
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

@end
