//
//  LPTurntableViewController.m
//  ProjectAnimation
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/4.
//  Copyright © 2019年 zero. All rights reserved.
//

#import "LPTurntableViewController.h"
#import "LPTurntableView.h"
#import "LPTurntableModel.h"

@interface LPTurntableViewController () <LPTurntableViewDelegate>

@end

@implementation LPTurntableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    LPTurntableView *turntable = [[LPTurntableView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.width)];
    turntable.delegate = self;
    //    turntable.indexValue = 1;
    [self.view addSubview:turntable];
}

- (void)showResultOfTurntablePointer:(LPTurntableModel *)turntable {
    
    NSString *title = @"抽中游戏结果";
    NSString *message = [NSString stringWithFormat:@"%@", turntable.name];
    NSString *sureTitle = @"确定";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
