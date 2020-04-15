//
//  UIView+RefreshTheme.m
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UIView+RefreshTheme.h"
#import <objc/runtime.h>
#import "BYDThemeManager.h"

static NSString *overviewKey  = @"overviewKey";
static NSString *viewtextKey  = @"viewtextKey";
static NSString *viewImageKey = @"viewImageKey";
static NSString *fontNameKey  = @"fontName";

@implementation UIView (RefreshTheme)

- (void)didMoveToSuperview {
    
    if (!BYDisStartTheme) {
        
        return;
    }
    
    NSMutableArray *arr = [BYDThemeManager getThemeViews];
    
    if (!arr) {
        
        arr = [NSMutableArray new];
    }
    if (![arr containsObject:self]) {
        
//        if (self.colorName || self.textColorName || self.imageName || self.fontName) {
//            
//            NSLog(@"1%@ ---- 2%@ ---- 3%@",self.colorName,self.textColorName,self.imageName);
            [arr addObject:self];
//        }
        [BYDThemeManager setThemeViews:arr];
    }
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
    if (!BYDisStartTheme) {
        
        return;
    }
    
        if (@available(iOS 13.0, *)) {
            
            if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
                
                if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    
                    NSLog(@"************* iOS13 黑夜模式");
                    [BYDThemeManager refreshTheme:@"BYD_ThemeType_DarkMode"];
                } else {
                    
                    NSLog(@"############# iOS13 普通模式");
                    [BYDThemeManager refreshTheme:@"BYD_ThemeType_Default"];
                }
            }
    
        }
}

// 背景色绑定
- (void)setColorName:(NSString *)colorName {
    
    objc_setAssociatedObject(self, &overviewKey,colorName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)colorName {
    
    return objc_getAssociatedObject(self, &overviewKey);
}

// 文本颜色绑定
- (void)setTextColorName:(NSString *)textColorName {
    
    objc_setAssociatedObject(self, &viewtextKey,textColorName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)textColorName {
    
    return objc_getAssociatedObject(self, &viewtextKey);
}

// 图片绑定
- (void)setImageName:(NSString *)imageName {
    
    objc_setAssociatedObject(self, &viewImageKey,imageName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)imageName {
    
    return objc_getAssociatedObject(self, &viewImageKey);
}

// 字体绑定
- (void)setFontName:(NSString *)fontName {
    
    objc_setAssociatedObject(self, &fontNameKey,fontName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)fontName {
    
    return objc_getAssociatedObject(self, &fontNameKey);
}

@end
