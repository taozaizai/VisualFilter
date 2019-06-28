//
//  ViewController.m
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/26.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import "ViewController.h"
#import "LVSFilter.h"
#import "FilterModel.h"
#import "FilterAjustView.h"
#import "TargetViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, FilterAjustViewDelegate, TargetViewControllerDelegate>

@property (nonatomic, copy) NSArray<FilterModel *> *dataSource;
@property (nonatomic, strong) UIImageView *staImg;
@property (nonatomic, strong) UIImageView *myImg;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FilterModel *selFilter;
@property (nonatomic, assign) int targetCategory;
@property (nonatomic, strong) UIImage *currentImg;
@property (nonatomic, strong) UIImage *tmpImg;

//记录参数
@property (nonatomic, strong) NSMutableDictionary *filtersPara;
@property (nonatomic, strong) NSArray *currentPara;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.filtersPara = [[NSMutableDictionary alloc] init];
    
    NSString *json = [[NSBundle mainBundle] pathForResource:@"filter.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:json];
    NSError *error;
    NSArray *contentArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"----%@",error.localizedDescription);
    }
    NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in contentArray) {
        FilterModel *model = [FilterModel yy_modelWithDictionary:dic];
        [tmpArr addObject:model];
    }
    self.dataSource = tmpArr.copy;
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetBtn addTarget:self action:@selector(resetImg) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.frame = CGRectMake(SCREEN_WIDTH-100, 20, 60, 44);
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:resetBtn];
    
    UIButton *getParaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getParaBtn addTarget:self action:@selector(showParas) forControlEvents:UIControlEventTouchUpInside];
    getParaBtn.frame = CGRectMake(40, 20, 60, 44);
    [getParaBtn setTitle:@"参数" forState:UIControlStateNormal];
    [getParaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:getParaBtn];
    
    CGFloat top = 84;
    CGFloat iw = 154;
    CGFloat ih = 192;
    CGFloat gap = (self.view.bounds.size.width - 154*2)/3.0;
    
    
    self.staImg = [[UIImageView alloc] initWithFrame:CGRectMake(gap, top, iw, ih)];
    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(gap*2+iw, top, iw, ih)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ih + 30 + top, self.view.bounds.size.width, self.view.bounds.size.height - ih - 30 - top) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.staImg];
    [self.view addSubview:self.myImg];
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoSelTargetImg)];
    self.staImg.userInteractionEnabled = YES;
    [self.staImg addGestureRecognizer:tap];
    [self updateStandardImgView];
    [self resetImg];
}

- (void)showParas {
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithDictionary:self.filtersPara];
    
    if (self.selFilter) {
        [tmpDic setObject:self.currentPara ? : @[] forKey:self.selFilter.filterName];
    }
    NSMutableString *msg = @"".mutableCopy;
    for (NSString *name in tmpDic.allKeys) {
        NSArray *paras = tmpDic[name];
        [msg appendFormat:@"filterName: %@;", name];
        for (NSDictionary *dic in paras) {
            NSString *dicStr = dic.description;
            [msg appendString:dicStr];
            [msg appendString:@";"];
        }
        [msg appendString:@"\n"];
     }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resetImg {
    self.currentImg = [UIImage imageNamed:@"0.jpg"];
    self.tmpImg = self.currentImg;
    self.myImg.image = self.currentImg;
    [self.filtersPara removeAllObjects];
    self.currentPara = nil;
    self.selFilter = nil;
}

- (void)gotoSelTargetImg {
    TargetViewController *vc = [[TargetViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FilterModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.filterName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterModel *filter = self.dataSource[indexPath.row];
    if (self.selFilter) {
        [self.filtersPara setObject:self.currentPara ? : @[] forKey:self.selFilter.filterName];
        self.currentPara = nil;
    }
    self.currentImg = self.tmpImg;
    self.selFilter = filter;
    [self showParaJustView];
}

- (void)showParaJustView {
    FilterAjustView *view = [[FilterAjustView alloc] initWithFilter:self.selFilter];
    view.frame = CGRectMake(0, 50, alert_width, alert_height);
    view.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    [self newInputParaValues:[view getParas]];
}

- (void)updateStandardImgView {
    UIImage *updateImg = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", self.targetCategory]];
    self.staImg.image = updateImg;
}

#pragma mark - FilterAjustViewDelegate

- (void)newInputParaValues:(NSArray *)paras {
    UIImage *originImg = self.currentImg;
    NSString *filterName = self.selFilter.filterName;
    CIFilter *filter = [CIFilter filterWithName:filterName];
    for (NSDictionary *dict in paras) {
        NSString *key = dict.allKeys.firstObject;
        id value = dict[key];
        [filter setValue:value forKey:key];
    }
    
    UIImage *processImage = [LVSFilter applyImage:originImg filter:filter];
    if (processImage!=nil) {
        self.myImg.image = processImage;
        self.tmpImg = processImage;
        self.currentPara = paras;
    }
}

#pragma mark - TargetViewControllerDelegate
- (void)didSelectTargetCategory:(int)category {
    self.targetCategory = category;
    [self updateStandardImgView];
}

@end
