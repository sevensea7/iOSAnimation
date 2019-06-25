//
//  LPWaterWaveViewController.m
//  ProjectAnimation
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/4.
//  Copyright © 2019年 zero. All rights reserved.
//

#import "LPWaterWaveViewController.h"
#import "LPWaterWaveView.h"

@interface LPWaterWaveViewController ()

@end

@implementation LPWaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    LPWaterWaveView *waterView = [[LPWaterWaveView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 80)];
    [self.view addSubview:waterView];
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
