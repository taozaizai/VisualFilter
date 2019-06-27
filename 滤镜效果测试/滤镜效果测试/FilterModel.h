//
//  FilterModel.h
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN


@interface FilterAttribute : NSObject <YYModel>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray <NSNumber *> *defaultValues;
@property (nonatomic, copy) NSArray <NSNumber *> *max;
@property (nonatomic, copy) NSArray <NSNumber *> *min;


@end

@interface FilterModel : NSObject <YYModel>


@property (nonatomic, copy) NSString *filterName;
@property (nonatomic, copy) NSArray<FilterAttribute *> *attributes;


@end




NS_ASSUME_NONNULL_END
