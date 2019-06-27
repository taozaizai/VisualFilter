//
//  FilterAjustView.h
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FilterAjustViewDelegate <NSObject>

- (void)newInputParaValues:(NSArray *)paras;

@end


@interface FilterAjustView : UIView

@property (nonatomic, weak) id<FilterAjustViewDelegate> delegate;

- (instancetype)initWithFilter:(FilterModel *)filter;
- (NSArray *)getParas;

@end

NS_ASSUME_NONNULL_END
