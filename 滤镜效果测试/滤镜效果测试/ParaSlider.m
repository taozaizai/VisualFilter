//
//  ParaSlider.m
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import "ParaSlider.h"

@interface ParaSlider()

@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat defaultValue;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation ParaSlider

- (instancetype)initWithSliderName:(NSString *)name defaultValue:(CGFloat)defaultValue maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    if (self = [super initWithFrame:CGRectZero]) {
        _maxValue = maxValue;
        _minValue = minValue;
        _defaultValue = defaultValue;
        _name = name;
        [self configView];
    }
    return self;
}

- (void)configView {
    UILabel *name = [[UILabel alloc] init];
    name.text = self.name;
    name.textColor = [UIColor redColor];
    name.frame = CGRectMake(0, 0, alert_width, 30);
    [self addSubview:name];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.maximumValue = self.maxValue;
    slider.minimumValue = self.minValue;
    slider.value = self.defaultValue;
    slider.frame = CGRectMake(20, 40, alert_width-100, 30);
    [slider addTarget:self action:@selector(sliderChanges:) forControlEvents:UIControlEventValueChanged];
    self.slider = slider;
    [self addSubview:slider];
    
    UILabel *valueLabel = [[UILabel alloc] init];
    valueLabel.backgroundColor = [UIColor blackColor];
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.frame = CGRectMake(alert_width-100+5, 40, 80, 30);
    self.valueLabel = valueLabel;
    [self addSubview:valueLabel];
    
    self.bounds = CGRectMake(0, 0, alert_width, 30+10+30+5);
    [self updateValueLabel:self.slider.value];
    
}

- (void)sliderChanges:(UISlider *)slider {
    [self updateValueLabel:slider.value];
}

- (CGFloat)value {
    return self.slider.value;
}

- (void)updateValueLabel:(CGFloat)value {
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f",value];
    if (self.delegate && [self.delegate respondsToSelector:@selector(valueHasChanged)]) {
        [self.delegate valueHasChanged];
    }
}


@end
