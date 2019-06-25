//
//  LPHeaderView.m
//  ProjectAnimation
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/13.
//  Copyright © 2019年 zero. All rights reserved.
//

#import "LPHeaderView.h"

@interface LPHeaderView ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation LPHeaderView

- (instancetype)initWithFrame:(CGRect)frame
              backgroundImage:(NSString *)backImageName
                   haderImage:(NSString *)headerImageName
                        title:(NSString *)title
                     subTitle:(NSString *)subTitle {
    self = [super initWithFrame:frame];
    if (self) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -0.5 * frame.size.height, frame.size.width, frame.size.height * 1.5)];
        _backImageView.image = [UIImage imageNamed:backImageName];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_backImageView];
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * 0.5 - 70 * 0.5, 0.27 * frame.size.height, 70, 70)];
        _headerImageView.image = [UIImage imageNamed:headerImageName];
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = _headerImageView.width / 2;
        _headerImageView.userInteractionEnabled = YES;
        [self addSubview:_headerImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.6 * frame.size.height, frame.size.width, frame.size.height * 0.2)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, frame.size.height*0.2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14] } context:nil].size;
        if (titleSize.width > frame.size.width *0.5) {
            titleSize.width = frame.size.width *0.5;
        }
        _titleLabel.frame = CGRectMake(frame.size.width * 0.5 - titleSize.width * 0.5, 0.6 * frame.size.height, titleSize.width, frame.size.height * 0.2);
        
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.75 * frame.size.height, frame.size.width, frame.size.height * 0.1)];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.text = subTitle;
        _subTitleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_subTitleLabel];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.height, 0, 0, 0);
    // 右边和底部指示线的位置 和偏移量保持一致
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGPoint newOffset = [change[@"new"] CGPointValue];
    [self updateSubViewsWithScrollOffset:newOffset];
}

- (void)updateSubViewsWithScrollOffset:(CGPoint)newOffset {
    
    // 悬停目标位置
    CGFloat destinaOffset = - 64;
    // 此时 startChangeOffSet 该值是负数 -205
    CGFloat startChangeOffset = - self.scrollView.contentInset.top;
    // 对于 y 和临界值的判断 赋值
    CGFloat y;
    if (newOffset.y < startChangeOffset) {
        y = startChangeOffset;
    } else if (newOffset.y > destinaOffset) {
        y = destinaOffset;
    } else {
        y = newOffset.y;
    }
    newOffset = CGPointMake(newOffset.x, y);
    // 205 - 40 = 165
    CGFloat subviewOffset = self.frame.size.height - 40 ; // 子视图的偏移量
    //  -newOffset.y -> 正数
    // - -205 - 205 = 0
    // 向上移动 newOffset.y 该数值就会由 -205 下降 - 64 。。 得出的结果是负数
    // 向下移动 newOffset.y 该数组就会由-64 上升 -205 。。。 得到的结果是正数
    // 用来设置改头部视图的 y 值  取值范围（-141， 0）
    CGFloat newY = -newOffset.y - self.scrollView.contentInset.top;
    // d 得到一个距离的绝对差 是正数 -64 + 205 = 141 可移动的范围 这是一个定值
    CGFloat d = destinaOffset - startChangeOffset; // 141
    
    // 计算透明度 // 1 - (-201（x） + 205) / d
    // 可移动x 移动的范围 -64 ~ -205
    //-64 + 205 = 141 -> 1 ; -205 + 205 = 0 -> 0
    CGFloat alpha = 1 - (newOffset.y - startChangeOffset) / d;
    // 1 - 141/ 141 * 2  = 0.5 透明度最小达到0.5即可 最大是1
    CGFloat imageReduce = 1 - (newOffset.y - startChangeOffset) / (d * 2);
    
    // 设置控件移动过程中透明度的变化
    self.subTitleLabel.alpha  = alpha;
    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);
    
    // 向下移动 alpha 达到最大值1此时 恢复 初始化 frame
    // 向上移动 alpha 达到最小值0此时 y = -0.5*self.frame.size.height+ 1.5*self.frame.size.height-64 =  self.frame.size.height-64 = 141
    // headerview 向上外部移动 backImageView 向下移动 141
    self.backImageView.frame = CGRectMake(0, -0.5 * self.frame.size.height + (1.5 * self.frame.size.height - 64) * (1 - alpha), self.backImageView.frame.size.width, self.backImageView.frame.size.height);
    
    // 向下移动 alpha 达到最大值1此时 CGAffineTransformMakeTranslation(0,0);
    // 向上移动 alpha 达到最小值0此时  CGAffineTransformMakeTranslation(0,(subviewOffset-0.35*self.frame.size.height)); // (0, 93)
    CGAffineTransform t =CGAffineTransformMakeTranslation(0,(subviewOffset-0.38*self.frame.size.height)*(1-alpha));
    //    CGAffineTransformMakeTranslation(0, 93) // 是一个偏移量 在y方向上的一个位移量
    _headerImageView.transform = CGAffineTransformScale(t, imageReduce, imageReduce);
    
    // 达到最佳状态 头像和名字并排 总长度
    CGFloat totalWidth = 35 + 10 + _titleLabel.frame.size.width;
    
    // frame.size.width*0.5-70*0.5
    // 头像初始状态是 x 的位置
    CGFloat icon_StartX = self.frame.size.width * 0.5 - 70 * 0.5;
    
    // 头像完成状态时 X 的位置
    CGFloat icon_EndX = self.frame.size.width * 0.5 - totalWidth * 0.5;
    
    // 头像的偏移量
    CGFloat iconOffsetX;
    iconOffsetX = ABS(icon_StartX - icon_EndX);
    
    CGRect rect_headerImageView = self.headerImageView.frame;
    if (icon_StartX > icon_EndX) {
        rect_headerImageView.origin.x = self.frame.size.width * 0.5 - 70 * 0.5 - (iconOffsetX) * (1 - alpha);
    } else {
        rect_headerImageView.origin.x = self.frame.size.width * 0.5 - 70 * 0.5 + (iconOffsetX) * (1 - alpha);
    }
    self.headerImageView.frame = rect_headerImageView;
    
    // 标题初始状态时 x 的位置
    CGFloat title_StartX = self.frame.size.width * 0.5 - _titleLabel.frame.size.width * 0.5;
    // 标题结束状态时 x 的位置
    CGFloat title_EndX = icon_EndX  + 35  + 10;
    
    // 标题的偏移量
    CGFloat titleOffsetX =  ABS(title_EndX - title_StartX);
    CGRect rect_titleLabel = self.titleLabel.frame;
    rect_titleLabel.origin.y = 0.6 * self.frame.size.height + (self.frame.size.height - 0.85 * self.frame.size.height) * (1 - alpha);
    
    if (title_EndX > title_StartX) {
        rect_titleLabel.origin.x = (self.frame.size.width * 0.5 - self.titleLabel.frame.size.width * 0.5) + titleOffsetX * (1 - alpha);
    } else {
        rect_titleLabel.origin.x = (self.frame.size.width * 0.5 - self.titleLabel.frame.size.width * 0.5) - titleOffsetX * (1 - alpha);
    }
    self.titleLabel.frame = rect_titleLabel;
    
    self.subTitleLabel.frame = CGRectMake(0, 0.75 * self.frame.size.height + (subviewOffset - 0.45 * self.frame.size.height) *  (1 - alpha), self.frame.size.width, self.frame.size.height * 0.1);
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
