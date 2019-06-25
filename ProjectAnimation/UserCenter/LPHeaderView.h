//
//  LPHeaderView.h
//  ProjectAnimation
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/13.
//  Copyright © 2019年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPHeaderView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;

- (instancetype)initWithFrame:(CGRect)frame
              backgroundImage:(NSString *)backImageName
                   haderImage:(NSString *)headerImageName
                        title:(NSString *)title
                     subTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
