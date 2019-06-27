//
//  LVSFilter.m
//  KGListenModule
//
//  Created by 赵桃园 on 2019/6/17.
//

#import "LVSFilter.h"
#import <CoreImage/CoreImage.h>

@implementation LVSFilter

+ (CIFilter *)filterWithFilterCategory:(LVSFilterCategory)category {
    NSString *name = [self nameWithCategory:category];
    CIFilter *filter = [CIFilter filterWithName:name];
    switch (category) {
        case LVSFilterCategory_none:
        {
            
        }
        break;
        case LVSFilterCategory_mingLiang:
        {
            //0.5的饱和度和对比度
            NSNumber *saturation = @(0.5);
            NSNumber *brightness = @(1);
            NSNumber *contrast = @(0.5);
            [filter setValue:saturation forKey:@"inputSaturation"];
            [filter setValue:brightness forKey:@"inputBrightness"];
            [filter setValue:contrast forKey:@"inputContrast"];
            
        }
        break;
        case LVSFilterCategory_qinXin:
        {
            //0.8的rgb
            CIVector *r = [CIVector vectorWithX:0 Y:0.8 Z:0 W:0];
            CIVector *g = [CIVector vectorWithX:0 Y:0.8 Z:0 W:0];
            CIVector *b = [CIVector vectorWithX:0 Y:0.8 Z:0 W:0];
            CIVector *a = [CIVector vectorWithX:0 Y:0.8 Z:0 W:0];
            
            [filter setValue:r forKey:@"inputRedCoefficients"];
            [filter setValue:g forKey:@"inputGreenCoefficients"];
            [filter setValue:b forKey:@"inputBlueCoefficients"];
            [filter setValue:a forKey:@"inputAlphaCoefficients"];

        }
        break;
        case LVSFilterCategory_cunZhen:
        {
            CIColor *color = [CIColor colorWithRed:0.3 green:0.3 blue:0.3];
            [filter setValue:color forKey:@"inputColor"];
        }
        break;
        case LVSFilterCategory_chuXin:
        {
            //hue 正向偏移60度
            CGFloat hueAngle = -M_PI/3.0f;
            [filter setValue:@(hueAngle) forKey:@"inputAngle"];
        }
        break;
        case LVSFilterCategory_keKou:
        {
            
        }
        break;
        case LVSFilterCategory_oldPhoto:
        {
            
        }
        break;
        case LVSFilterCategory_blackWhite:
        {
            
        }
        break;
        case LVSFilterCategory_film:
        {
            
        }
        break;
        
        default:
        break;
    }
    return filter;
}

+ (NSString *)nameWithCategory:(LVSFilterCategory)category {
    NSString *name;
    switch (category) {
        case LVSFilterCategory_none:
        {
            name = @"CIColorMatrix";
        }
        break;
        case LVSFilterCategory_mingLiang:
        {
            name = @"CIColorControls";
        }
        break;
        case LVSFilterCategory_qinXin:
        {
            name = @"CIColorPolynomial";
        }
        break;
        case LVSFilterCategory_cunZhen:
        {
            name = @"CIWhitePointAdjust";
        }
        break;
        case LVSFilterCategory_chuXin:
        {
            name = @"CIHueAdjust";
        }
        break;
        case LVSFilterCategory_keKou:
        {
            name = @"CIColorCubeWithColorSpace";
        }
        break;
        case LVSFilterCategory_oldPhoto:
        {
            name = @"CIPhotoEffectInstant";
        }
        break;
        case LVSFilterCategory_blackWhite:
        {
            name = @"CIPhotoEffectNoir";
        }
        break;
        case LVSFilterCategory_film:
        {
            name = @"CIPhotoEffectChrome";
        }
        break;
        
        default:
        break;
    }
    
    return name;
}

+ (UIImage *)applyImage:(UIImage *)input category:(LVSFilterCategory)category {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [self filterWithFilterCategory:category];
    CIImage *inputCiImg = [[CIImage alloc] initWithImage:input];
    [filter setValue:inputCiImg forKey:kCIInputImageKey];
    CIImage *outImg = [filter outputImage];
    CGRect extent = [outImg extent];
    CGImageRef cgImage = [context createCGImage:outImg fromRect:extent];
    UIImage *resImg = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resImg;
}

+ (UIImage *)applyImage:(UIImage *)input filter:(CIFilter *)filter {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputCiImg = [[CIImage alloc] initWithImage:input];
    [filter setValue:inputCiImg forKey:kCIInputImageKey];
    CIImage *outImg = [filter outputImage];
    CGRect extent = [outImg extent];
    CGImageRef cgImage = [context createCGImage:outImg fromRect:extent];
    UIImage *resImg = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resImg;
}
    
+ (NSString *)filterDescNameWithFilterCategory:(LVSFilterCategory)category {
    NSString *name;
    switch (category) {
        case LVSFilterCategory_none:
        {
            name = @"原图";
        }
        break;
        case LVSFilterCategory_mingLiang:
        {
            name = @"明亮";
        }
        break;
        case LVSFilterCategory_qinXin:
        {
            name = @"清新";
        }
        break;
        case LVSFilterCategory_cunZhen:
        {
            name = @"纯真";
        }
        break;
        case LVSFilterCategory_chuXin:
        {
            name = @"初心";
        }
        break;
        case LVSFilterCategory_keKou:
        {
            name = @"可口";
        }
        break;
        case LVSFilterCategory_oldPhoto:
        {
            name = @"老照片";
        }
        break;
        case LVSFilterCategory_blackWhite:
        {
            name = @"过往";
        }
        break;
        case LVSFilterCategory_film:
        {
            
        }
        break;
        default:
        break;
    }
    return name;
}

//+ (NSArray<FilterModel *> *)parasWithFilter:(CIFilter *)filter {
//    NSString *name = filter.name;
//    NSMutableArray *resArr = [NSMutableArray array];
//    if ([name isEqualToString:@"CIHueAdjust"]) {
//        FilterModel *model = [[FilterModel alloc] initWithParaName:@"inputAngle" paraCls:[NSNumber class]];
//        model.maxValue = M_PI*2;
//        model.minValue = -M_PI*2;
//        model.defaultValue = @(0);
//        model.cls = [NSNumber class];
//        [resArr addObject:model];
//    } else if ([name isEqualToString:@"CIColorControls"]) {
//        NSArray *arrributes= @[@"inputSaturation", @"inputBrightness", @"inputContrast"];
//        NSArray *defaultValues = @[@(1),@(0), @(1)];
//        NSInteger index = 0;
//        for (NSString *attribute in arrributes) {
//            FilterModel *model = [[FilterModel alloc] initWithParaName:attribute paraCls:[NSNumber class]];
//            model.maxValue = 2;
//            model.minValue = -2;
//            model.defaultValue = defaultValues[index];
//            model.paraCount = 3;
//            model.floatNames = @[];
//            index += 1;
//            [resArr addObject:model];
//        }
//    } else if ([name isEqualToString:@"CIColorPolynomial"]) {
//        NSArray *arrributes= @[@"inputRedCoefficients", @"inputGreenCoefficients", @"inputBlueCoefficients", @"inputAlphaCoefficients"];
//        for (NSString *attribute in arrributes) {
//            FilterModel *model = [[FilterModel alloc] initWithParaName:attribute paraCls:[CIVector class]];
//            model.maxValue = 3;
//            model.minValue = -3;
//            model.defaultValue = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
//            model.paraCount = 4;
//            model.floatNames = @[@"x", @"y", @"z", @"w"];
//            [resArr addObject:model];
//        }
//    } else if ([name isEqualToString:@"CIWhitePointAdjust"]) {
//        NSArray *arrributes= @[@"inputColor"];
//        for (NSString *attribute in arrributes) {
//            FilterModel *model = [[FilterModel alloc] initWithParaName:attribute paraCls:[CIColor class]];
//            model.maxValue = 2;
//            model.minValue = 0;
//            model.defaultValue = [CIColor colorWithRed:0 green:0 blue:0];
//            model.paraCount = 3;
//            model.floatNames = @[@"r", @"g", @"b"];
//            [resArr addObject:model];
//        }
//    }
//
//    return resArr;
//}


@end
