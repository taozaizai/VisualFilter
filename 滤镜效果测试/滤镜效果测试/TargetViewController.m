//
//  TargetViewController.m
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import "TargetViewController.h"
#import "LVSFilter.h"

@interface TargetViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[
                        @(LVSFilterCategory_none),
                        @(LVSFilterCategory_mingLiang),
                        @(LVSFilterCategory_qinXin),
                        @(LVSFilterCategory_cunZhen),
                        @(LVSFilterCategory_chuXin),
                        @(LVSFilterCategory_keKou),
                        @(LVSFilterCategory_oldPhoto),
                        @(LVSFilterCategory_blackWhite),
                        @(LVSFilterCategory_film),
                        ];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    int category = [self.dataSource[indexPath.row] intValue];
    cell.textLabel.text = [LVSFilter filterDescNameWithFilterCategory:category];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int category = [self.dataSource[indexPath.row] intValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectTargetCategory:)]) {
        [self.delegate didSelectTargetCategory:category];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
