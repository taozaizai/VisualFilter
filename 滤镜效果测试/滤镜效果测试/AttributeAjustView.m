//
//  AttributeAjustView.m
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import "AttributeAjustView.h"
#import <objc/runtime.h>
#import "ParaSlider.h"

@interface AttributeAjustView ()<ParaSliderDelegate>

@property (nonatomic, strong) NSMutableArray <ParaSlider *> *sliders;

@end

@implementation AttributeAjustView

- (instancetype)initWithFilterAttribute:(FilterAttribute *)attribute {
    if (self = [super initWithFrame:CGRectZero]) {
        _attribute = attribute;
        _sliders = [[NSMutableArray alloc] init];
        [self configSliders];
    }
    return self;
}

- (void)configSliders {
    CGFloat height = 0;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = self.attribute.name;
    nameLabel.textColor = [UIColor redColor];
    nameLabel.frame = CGRectMake(0, 0, alert_width, 30);
    [self addSubview:nameLabel];
    height += 40;
    
    NSArray *paraNames = [self getParaNames:self.attribute.type];
    
    for (NSInteger i=0; i<self.attribute.defaultValues.count; i++) {
        
        CGFloat defaultValue = [self.attribute.defaultValues[i] floatValue];
        NSString *floatName = @"";
        if (paraNames.count > i) {
            floatName = paraNames[i];
        }
        CGFloat max = [self.attribute.max[i] floatValue];
        CGFloat min = [self.attribute.min[i] floatValue];
        
        ParaSlider *slider = [[ParaSlider alloc] initWithSliderName:floatName defaultValue:defaultValue maxValue:max minValue:min];
        slider.delegate = self;
        
        slider.frame = CGRectMake(0, height, alert_width, slider.bounds.size.height);
        height += slider.bounds.size.height + 10;
        [self addSubview:slider];
        [self.sliders addObject:slider];
    }
    
    self.bounds = CGRectMake(0, 0, alert_width, height);
    
}

- (NSArray *)getParaNames:(NSString *)clsType {
    NSArray *arr = [NSArray array];
    if ([clsType isEqualToString:@"CIColor"]) {
        return @[@"red", @"green", @"blue"];
    } else if ([clsType isEqualToString:@"CIVector"]) {
        return @[@"x", @"y", @"z", @"w"];
    } else if ([clsType isEqualToString:@"CIVector3"]) {
        return @[@"x", @"y", @"z"];
    }
    return arr;
}



- (id)getValue {
    if ([self.attribute.type isEqualToString:@"NSNumber"]) {
        ParaSlider *slider = [self.sliders firstObject];
        if (slider) {
            NSNumber *value = @([slider value]);
            return value;
        }
    } else if ([self.attribute.type isEqualToString:@"CIVector"]) {
        CGFloat values[self.attribute.defaultValues.count];
        for (NSInteger i=0; i<self.sliders.count; i++) {
            ParaSlider *slider = self.sliders[i];
            values[i] = slider.value;
        }
        CIVector *vector = [CIVector vectorWithValues:values count:self.attribute.defaultValues.count];
        return vector;
    } else if ([self.attribute.type isEqualToString:@"CIColor"]) {
        CGFloat values[self.attribute.defaultValues.count];
        for (NSInteger i=0; i<self.sliders.count; i++) {
            ParaSlider *slider = self.sliders[i];
            values[i] = slider.value;
        }
        CIColor *color = [CIColor colorWithRed:values[0] green:values[1] blue:values[2]];
        return color;
    }
    return nil;
}

#pragma mark - ParaSliderDelegate

- (void)valueHasChanged {
    if (self.deleaget && [self.deleaget respondsToSelector:@selector(valueHasChanged)]) {
        [self.deleaget valueHasChanged];
    }
}

@end
