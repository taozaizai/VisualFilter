//
//  FilterModel.m
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterAttribute

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"defaultValues": [NSObject class],
             @"max" : [NSNumber class],
             @"min" : [NSNumber class],
             };
}

@end


@implementation FilterModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"attributes": [FilterAttribute class]};
}


@end



