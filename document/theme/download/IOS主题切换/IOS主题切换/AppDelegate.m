//
//  AppDelegate.m
//  IOS主题切换
//
//  Created by chenanyang on 2020/3/20.
//  Copyright © 2020 chenanyang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "BYDThemeManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *VC = [[ViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:VC];
    [self.window makeKeyAndVisible];
    
    BYDStartTheme;
    return YES;
}

@end
