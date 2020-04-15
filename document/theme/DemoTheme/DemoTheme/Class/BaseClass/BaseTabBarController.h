//
//  BaseTabBarController.h
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/11/26.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "SettingViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarController : UITabBarController

@property (nonatomic, strong) MainViewController *mainVC;
@property (nonatomic, strong) SettingViewController *settingVC;

@end

NS_ASSUME_NONNULL_END
