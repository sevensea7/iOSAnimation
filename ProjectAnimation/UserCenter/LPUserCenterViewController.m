//
//  LPUserCenterViewController.m
//  ProjectAnimation
//
//  Created by 杭州任性智能科技有限公司 on 2019/3/13.
//  Copyright © 2019年 zero. All rights reserved.
//

#import "LPUserCenterViewController.h"
#import "LPHeaderView.h"
#import "iOSPalette.h"

@interface LPUserCenterViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LPHeaderView *headerView;

@end

@implementation LPUserCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInsetAdjustmentBehavior  = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.tableView];
    
    self.headerView = [[LPHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 205) backgroundImage:@"backImage" haderImage:@"userIcon" title:@"薇尔莉特" subTitle:@"紫罗兰永恒花园"];
    self.headerView.scrollView = self.tableView;
    [self.view addSubview:self.headerView];
    
    [[UIImage imageNamed:@"backImage"] getPaletteImageColor:^(PaletteColorModel *recommendColor, NSDictionary *allModeColorDic, NSError *error) {
        NSString *color = recommendColor.imageColorString;
        NSLog(@"%@", color);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行 -- (点击返回)", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat down = - (205 * 1) - scrollView.contentOffset.y;
//    if (down < 0) {
//        return;
//    }
//    CGRect frame = self.headerView.backImageView.frame;
//    frame.origin.y = scrollView.contentOffset.y;
//    frame.size.height = - scrollView.contentOffset.y;
//    self.headerView.backImageView.frame = frame;
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
