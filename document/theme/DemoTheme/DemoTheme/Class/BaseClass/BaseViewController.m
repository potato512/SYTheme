//
//  BaseViewController.m
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/11/26.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    [self setNavigationStyle:[UIColor whiteColor] textColor:[UIColor blackColor] textFont:kFontSize(20)];
    //
    if ([self.navigationController.viewControllers.firstObject isEqual:self]) {
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        if (self.backButton == nil) {
            self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
            [self.backButton setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
            [self.backButton setImage:[UIImage imageNamed:@"back_highlight"] forState:UIControlStateHighlighted];
            [self.backButton addTarget:self action:@selector(backPreviousController) forControlEvents:UIControlEventTouchUpInside];
        }
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    }
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme:) name:@"changeTheme" object:nil];
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)setNavigationStyle:(UIColor *)backgroundColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont
{
    // 背景色
    if (backgroundColor) {
        [self.navigationController.navigationBar setBarTintColor:backgroundColor];
        self.navigationController.navigationBar.translucent = NO;
    }
    
    // 返回按钮标题颜色
    if (textColor) {
        self.navigationController.navigationBar.tintColor = textColor;
    }
    
    // 字体
    if (textColor && textFont) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:textFont, NSForegroundColorAttributeName:textColor};
    }
}

- (void)backPreviousController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeTheme:(NSNotification *)notification
{
    // @[@"默认", @"黑夜", @"红色", @"蓝色", @"绿色"];
    
    NSNumber *number = notification.object;
    NSLog(@"%@", number);
    // 背景颜色
    // 导航栏颜色
    // 字体颜色
    // 图标
    
    
    
    
    
    if (0 == number.integerValue) {
        //
        self.view.backgroundColor = [UIColor whiteColor];
        //
        [self setNavigationStyle:[UIColor whiteColor] textColor:[UIColor blackColor] textFont:kFontSize(20)];
        //
        // 设置标题字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x000000)} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x515151)} forState:UIControlStateSelected];
        // 设置图标选中时颜色
        [[UITabBar appearance] setTintColor:UIColorHex(0x000000)];
    } else if (1 == number.integerValue) {
        //
        self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        //
        [self setNavigationStyle:[UIColor colorWithWhite:0.5 alpha:0.3] textColor:[UIColor whiteColor] textFont:kFontSize(20)];
        //
        // 设置标题字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x000000)} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x515151)} forState:UIControlStateSelected];
        // 设置图标选中时颜色
        [[UITabBar appearance] setTintColor:UIColorHex(0x000000)];
    } else if (2 == number.integerValue) {
        //
        self.view.backgroundColor = [UIColor whiteColor];
        //
        [self setNavigationStyle:[UIColor redColor] textColor:[UIColor whiteColor] textFont:kFontSize(20)];
        //
        // 设置标题字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x000000)} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
        // 设置图标选中时颜色
        [[UITabBar appearance] setTintColor:[UIColor redColor]];
    } else if (3 == number.integerValue) {
        //
        self.view.backgroundColor = [UIColor whiteColor];
        //
        [self setNavigationStyle:[UIColor blueColor] textColor:[UIColor whiteColor] textFont:kFontSize(20)];
        //
        // 设置标题字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x000000)} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateSelected];
        // 设置图标选中时颜色
        [[UITabBar appearance] setTintColor:[UIColor blueColor]];
    } else if (4 == number.integerValue) {
        //
        self.view.backgroundColor = [UIColor whiteColor];
        //
        [self setNavigationStyle:[UIColor greenColor] textColor:[UIColor whiteColor] textFont:kFontSize(20)];
        //
        // 设置标题字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorHex(0x000000)} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} forState:UIControlStateSelected];
        // 设置图标选中时颜色
        [[UITabBar appearance] setTintColor:[UIColor greenColor]];
    }
}

@end
