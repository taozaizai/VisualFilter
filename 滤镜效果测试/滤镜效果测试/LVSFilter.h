//
//  LVSFilter.h
//  KGListenModule
//
//  Created by 赵桃园 on 2019/6/17.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>
#import "FilterModel.h"


NS_ASSUME_NONNULL_BEGIN

//滤镜效果
typedef NS_ENUM(NSUInteger, LVSFilterCategory) {
    LVSFilterCategory_none = 0,
    LVSFilterCategory_mingLiang,
    LVSFilterCategory_qinXin,
    LVSFilterCategory_cunZhen,
    LVSFilterCategory_chuXin,
    LVSFilterCategory_keKou,
    LVSFilterCategory_oldPhoto,
    LVSFilterCategory_blackWhite,
    LVSFilterCategory_film,
};


@interface LVSFilter : NSObject


+ (CIFilter *)filterWithFilterCategory:(LVSFilterCategory)category;
+ (UIImage *)applyImage:(UIImage *)input category:(LVSFilterCategory)category;
+ (NSString *)filterDescNameWithFilterCategory:(LVSFilterCategory)category;
//+ (NSArray<FilterModel *> *)parasWithFilter:(CIFilter *)filter;
+ (NSString *)nameWithCategory:(LVSFilterCategory)category;

+ (UIImage *)applyImage:(UIImage *)input filter:(CIFilter *)filter;
@end

NS_ASSUME_NONNULL_END
