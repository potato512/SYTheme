//
//  BYDThemeManager.h
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+theme.h"
#import "UIImage+theme.h"
#import "UIFont+theme.h"
#import "UIView+RefreshTheme.h"

NS_ASSUME_NONNULL_BEGIN

// 主题本地key
#define BYDThemeKey     @"BYD_Theme_Local_Key"

// 主题名称
#define BYDThemeDefault @"BYD_ThemeType_Default"
#define BYDThemeDark    @"BYD_ThemeType_DarkMode"

// 开启主题替换
#define BYDisStartTheme    [BYDThemeManager isStartTheme] //是否开启
#define BYDStartTheme      [BYDThemeManager startThemeManager];// 开启
#define BYDEndTheme        [BYDThemeManager endThememanager];// 关闭

// x:属性key值，y:设置、持有属性的对象。
#define BYDBgColor(x,y)    [UIColor backColorWithKey:x container:y] // 背景色
#define BYDTextColor(x,y)  [UIColor textColorWithKey:x container:y] // 文本色
#define BYDImage(x,y)      [UIImage imageWithKey:x container:y]     // 图片
#define BYDFont(x,y)       [UIFont fontWithKey:x container:y]       // 字号

@interface BYDThemeManager : NSObject

+ (void)startThemeManager;
+ (void)endThememanager;
+ (void)refreshTheme:(NSString *)themeKey;

+ (BOOL)isStartTheme;

+ (NSDictionary *)getCurrentThemeColorData;
+ (NSDictionary *)getCurrentThemeImageData;
+ (NSDictionary *)getCurrentThemeFontData;

+ (NSMutableArray *)getThemeViews;
+ (void)setThemeViews:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
