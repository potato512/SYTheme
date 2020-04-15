//
//  BYDThemeManager.m
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BYDThemeManager.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 开启标志key
#define BYDSrartThemeKey     @"BYD_Theme_Start_Key"

// 主题资源文件名称.json
#define BYDThemeColorDefault @"colortheme"
#define BYDThemeColorDark    @"colorthemeDark"

#define BYDThemeImageDefault @"imagetheme"
#define BYDThemeImageDark    @"imagethemeDark"

#define BYDThemeFontDefault  @"fonttheme"
#define BYDThemeFontDark     @"fontthemeDark"

static NSMutableArray *themeViews;

static NSDictionary *colordata;
static NSDictionary *fontdata;
static NSDictionary *imagedata;

@implementation BYDThemeManager

#pragma mark - 获取主题资源
+ (NSDictionary *)getCurrentThemeColorData {
    
    NSString *themeKey =  [[NSUserDefaults standardUserDefaults] objectForKey:BYDThemeKey];
    if ([themeKey isEqualToString:BYDThemeDefault]) {
        
        themeKey = BYDThemeColorDefault;
    } else {
        
        themeKey = BYDThemeColorDark;
    }
    NSString *strPath            = [[NSBundle mainBundle] pathForResource:themeKey ofType:@"json"];
    NSString *parseJason         = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    NSData *data                 = [parseJason dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject                = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return jsonObject;
}

+ (NSDictionary *)getCurrentThemeImageData {
    
    NSString *themeKey =  [[NSUserDefaults standardUserDefaults] objectForKey:BYDThemeKey];
    if ([themeKey isEqualToString:BYDThemeDefault]) {
        
        themeKey = BYDThemeImageDefault;
    } else {
        
        themeKey = BYDThemeImageDark;
    }
    NSString *strPath            = [[NSBundle mainBundle] pathForResource:themeKey ofType:@"json"];
    NSString *parseJason         = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    NSData *data                 = [parseJason dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject                = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return jsonObject;
}

+ (NSDictionary *)getCurrentThemeFontData {
    
    NSString *themeKey =  [[NSUserDefaults standardUserDefaults] objectForKey:BYDThemeKey];
    if ([themeKey isEqualToString:BYDThemeDefault]) {
        
        themeKey = BYDThemeFontDefault;
    } else {
        
        themeKey = BYDThemeFontDark;
    }
    NSString *strPath            = [[NSBundle mainBundle] pathForResource:themeKey ofType:@"json"];
    NSString *parseJason         = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    NSData *data                 = [parseJason dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject                = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return jsonObject;
}

#pragma mark - 主题资源 标志位设置
+ (BOOL)isStartTheme {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:BYDSrartThemeKey];
}

+ (void)startThemeManager {
    
    if (!themeViews) {
        
        themeViews = [NSMutableArray new];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BYDSrartThemeKey];
    
    NSString *themeKey =  [[NSUserDefaults standardUserDefaults] objectForKey:BYDThemeKey];
    if (!themeKey) {
        
        [[NSUserDefaults standardUserDefaults] setObject:BYDThemeDefault forKey:BYDThemeKey];
    }
}

+ (void)endThememanager {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:BYDSrartThemeKey];
}

#pragma mark - 主题页面
+ (void)setThemeViews:(NSMutableArray *)arr {
    
    themeViews = arr;
}

+ (NSMutableArray *)getThemeViews {
    
    return themeViews;
}

#pragma mark - 刷新
+ (void)refreshTheme:(NSString *)themeKey {
    
    NSString *themeLOCAL = [[NSUserDefaults standardUserDefaults] objectForKey:BYDThemeKey];
    if ([themeLOCAL isEqualToString:themeKey]) {
        
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:themeKey forKey:BYDThemeKey];
    if (!themeViews) {
     
        return;
    }
    
    for (id container in themeViews) {
        
            if ([container isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = container;
            // color
            if (btn.colorName) {
                    
                btn.backgroundColor = BYDBgColor(btn.colorName, btn);
            }
            if (btn.textColorName) {
                    
                [btn setTitleColor:BYDTextColor(btn.textColorName, btn) forState:UIControlStateNormal];
            }
            // image
            if (btn.currentImage.imageName) {
                
                // btn.state todo
                [btn setImage:BYDImage(btn.imageView.image.imageName, btn) forState:UIControlStateNormal];
            }
            if (btn.currentBackgroundImage.imageName) {
                
                [btn setBackgroundImage:BYDImage(btn.currentBackgroundImage.imageName, btn) forState:UIControlStateNormal];
            }
        } else if ([container isKindOfClass:[UIImageView class]]) {
            
            UIImageView *img = container;
            if (img.image.imageName) {
                
                img.image = BYDImage(img.image.imageName, img);
            }
            if (img.colorName) {
                
                img.backgroundColor = BYDBgColor(img.colorName, img);
            }
        } else if ([container isKindOfClass:[UILabel class]]) {
            
            UILabel *lb = container;
            if (lb.font.fontName) {
                
                lb.font = BYDFont(lb.font.fontName, lb);
            }
            if (lb.colorName) {
                
                lb.backgroundColor = BYDBgColor(lb.colorName, lb);
            }
            if (lb.textColorName) {
                
                lb.textColor = BYDTextColor(lb.textColorName, lb);
            }
        } else if ([container isKindOfClass:[UITextField class]]) {
            
            UITextField *vie = container;
            if (vie.colorName) {
                
                vie.backgroundColor = BYDBgColor(vie.colorName, vie);
            }
            if (vie.textColorName) {
                
                vie.textColor = BYDTextColor(vie.textColorName, vie);
            }
        }
        else if ([container isKindOfClass:[UINavigationBar class]]) {
            
            UINavigationBar *bar = container;
            if (bar.colorName) {
                
                bar.backgroundColor = BYDBgColor(bar.colorName, bar);
            }
        } else if ([container isKindOfClass:[UIView class]]){
            
            UIView *view = container;
            
            if (view.colorName) {
                
                view.backgroundColor = BYDBgColor(view.colorName, view);
            }
        }
    }
}

@end
