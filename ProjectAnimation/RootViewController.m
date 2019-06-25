//
//  RootViewController.m
//  ProjectAnimation
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/4.
//  Copyright © 2019年 zero. All rights reserved.
//

#import "RootViewController.h"
#import "LPWaterWaveViewController.h"
#import "LPTurntableViewController.h"
#import "LPUserCenterViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"iOS复杂动画";
    [self initData];
    [self createTableView];
}

- (void)initData {
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.dataArr = @[@"波浪动画",
                     @"转盘动画",
                     @"个人中心"].mutableCopy;
}

- (void)createTableView {
    
    // tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            LPWaterWaveViewController *vc1 = [[LPWaterWaveViewController alloc] init];
            [self.navigationController pushViewController:vc1 animated:YES];
        }
            break;
        case 1: {
            LPTurntableViewController *vc2 = [[LPTurntableViewController alloc] init];
            [self.navigationController pushViewController:vc2 animated:YES];
        }
            break;
        case 2: {
            LPUserCenterViewController *vc3 = [[LPUserCenterViewController alloc] init];
            [self.navigationController pushViewController:vc3 animated:YES];
        }
            break;
        default:
            break;
    }
    
    
    
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
