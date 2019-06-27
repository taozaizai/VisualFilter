//
//  TargetViewController.h
//  滤镜效果测试
//
//  Created by 赵桃园 on 2019/6/27.
//  Copyright © 2019年 赵桃园. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TargetViewControllerDelegate <NSObject>

- (void)didSelectTargetCategory:(int)category;

@end

@interface TargetViewController : UIViewController

@property (weak, nonatomic) id<TargetViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
