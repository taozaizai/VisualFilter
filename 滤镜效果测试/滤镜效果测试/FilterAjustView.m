//
//  FilterAjustView.m
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import "FilterAjustView.h"
#import "AttributeAjustView.h"
#import "LVSFilter.h"

@interface FilterAjustView ()<AttributeAjustViewDelegate>

@property (nonatomic, strong) FilterModel *filter;
@property (nonatomic, strong) UIScrollView *sc;
@property (nonatomic, copy) NSArray <AttributeAjustView *> *paraViews;

@end


@implementation FilterAjustView

- (instancetype)initWithFilter:(FilterModel *)filter {
    if (self = [super initWithFrame:CGRectZero]) {
        _filter = filter;
        [self configSubView];
        
    }
    return self;
}

- (void)configSubView {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.frame = CGRectMake(0, 0, alert_width, alert_height);
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.sc = sc;
    [self addSubview:sc];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *delImg = [UIImage imageNamed:@"delete_icon"];
    [delBtn setImage:delImg forState:UIControlStateNormal];
    delBtn.frame = CGRectMake(self.bounds.size.width-delImg.size.width, 0, delImg.size.width, delImg.size.height);
    [delBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:delBtn];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.filter.filterName;
    label.textColor = [UIColor redColor];
    label.frame = CGRectMake(0, 0, alert_width, 30);
    [self.sc addSubview:label];
    
    CGFloat y = 40;
    CGFloat gap = 10;
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (FilterAttribute *attribute in self.filter.attributes) {
        AttributeAjustView *justV = [[AttributeAjustView alloc] initWithFilterAttribute:attribute];
        [self.sc addSubview:justV];
        justV.frame = CGRectMake(0, y, alert_width, justV.bounds.size.height);
        y+=justV.bounds.size.height+gap;
        justV.deleaget = self;
        [tmpArr addObject:justV];
    }
    self.paraViews = tmpArr.copy;
    
    
    sc.contentSize = CGSizeMake(alert_width, y+10);
}

-(void)close {
    [self removeFromSuperview];
}

- (NSArray *)getParas {
    NSMutableArray *paras = [[NSMutableArray alloc] init];
    for (AttributeAjustView *justV in self.paraViews) {
        id value =  [justV getValue];
        if (value) {
            NSString *attribute = justV.attribute.name;
            [paras addObject:@{attribute: value}];
        }
    }
    return paras;
}


#pragma mark - AttributeAjustViewDelegate

- (void)valueHasChanged {
    
    NSArray *paras = [self getParas];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(newInputParaValues:)]) {
        
        [self.delegate newInputParaValues:paras];
        
    }
}

@end
