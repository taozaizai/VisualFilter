//
//  ParaSlider.h
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ParaSliderDelegate <NSObject>

- (void)valueHasChanged;

@end

@interface ParaSlider : UIView

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, weak) id<ParaSliderDelegate> delegate;

- (instancetype)initWithSliderName:(NSString *)name defaultValue:(CGFloat)defaultValue maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue;

@end

NS_ASSUME_NONNULL_END
