//
//  ViewController.m
//  IOS主题切换
//
//  Created by chenanyang on 2020/3/20.
//  Copyright © 2020 chenanyang. All rights reserved.
//

#import "ViewController.h"
#import "BYDThemeManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 200, 50);
    view.center = CGPointMake(self.view.center.x, 200);
    [self.view addSubview:view];
    
    UIImageView *img = [UIImageView new];
    img.frame = CGRectMake(0, 0, 200, 50);
    img.center = CGPointMake(view.center.x, view.center.y + 100);
    [self.view addSubview:img];
    
    UILabel *lbfont = [UILabel new];
    lbfont.frame = CGRectMake(0, 0, 200, 50);
    lbfont.center = CGPointMake(img.center.x, img.center.y + 100);
    lbfont.textAlignment = NSTextAlignmentCenter;
    lbfont.text = @"666666";
    [self.view addSubview:lbfont];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, 200, 50);
    btn.center = CGPointMake(lbfont.center.x, lbfont.center.y + 100);
    [btn setTitle:@"按钮按钮" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(refreshTheme) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
#pragma mark - 
    view.backgroundColor = BYDBgColor(@"subviewBGColor", view);
    
    img.image = BYDImage(@"imageVimage", img);
    
    lbfont.textColor = BYDTextColor(@"subviewBGColor", lbfont);
    lbfont.font = BYDFont(@"lbFont", lbfont);
    lbfont.backgroundColor = BYDBgColor(@"black", lbfont);
    
    btn.backgroundColor = BYDBgColor(@"btnBGColor", btn);
    [btn setTitleColor:BYDTextColor(@"black", btn) forState:UIControlStateNormal];
    
    self.view.backgroundColor = BYDBgColor(@"white", self.view);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// test 
- (void)refreshTheme {
    
    NSString *theme = [[NSUserDefaults standardUserDefaults] objectForKey:BYDThemeKey];
    if ([theme isEqualToString:@"BYD_ThemeType_DarkMode"]) {
        
        theme = @"BYD_ThemeType_Default";
        self.navigationItem.title = @"iOS13 普通模式";
        
    } else {
        
        theme = @"BYD_ThemeType_DarkMode";
        self.navigationItem.title = @"iOS13 黑夜模式";
    }
    [BYDThemeManager refreshTheme:theme];
}

@end
