//
//  BaseTabBarController.m
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/11/26.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeTab];
}

+ (void)initialize
{
    /*
     normal: d81e06, 000000
     highlight:e16531, 515151
     
    */
    
    // 设置标题字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x000000)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x515151)} forState:UIControlStateSelected];
    
    // 设置标题字体大小
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11.0]} forState:UIControlStateNormal];
    
    // 设置标题字体偏移
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -3.0)];
    
    // 设置图标选中时颜色
    [[UITabBar appearance] setTintColor:UIColorHex(0x000000)];
}

- (void)initializeTab
{
    UITabBarItem *mainItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"main_normal"] selectedImage:[UIImage imageNamed:@"main_highlight"]];
    self.mainVC.tabBarItem = mainItem;
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:self.mainVC];
    
    UITabBarItem *settingItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"setting_normal"] selectedImage:[UIImage imageNamed:@"setting_highlight"]];
    self.settingVC.tabBarItem = settingItem;
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:self.settingVC];
    
    self.viewControllers = @[mainNav, settingNav];
}

#pragma mark - getter

- (MainViewController *)mainVC
{
    if (_mainVC == nil) {
        _mainVC = [[MainViewController alloc] init];
    }
    return _mainVC;
}

- (SettingViewController *)settingVC
{
    if (_settingVC == nil) {
        _settingVC = [[SettingViewController alloc] init];
    }
    return _settingVC;
}



@end
