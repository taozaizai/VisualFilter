//
//  AttributeAjustView.h
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AttributeAjustViewDelegate <NSObject>

- (void)valueHasChanged;

@end

@interface AttributeAjustView : UIView

@property (nonatomic, strong) FilterAttribute *attribute;
@property (nonatomic, weak) id<AttributeAjustViewDelegate> deleaget;

- (instancetype)initWithFilterAttribute:(FilterAttribute *)attribute;

//{"inputRadius": 15}
- (id)getValue;

@end

NS_ASSUME_NONNULL_END
