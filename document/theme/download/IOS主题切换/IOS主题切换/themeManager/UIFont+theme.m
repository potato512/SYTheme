//
//  UIFont+theme.m
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UIFont+theme.h"
#import <objc/runtime.h>
#import "UIView+RefreshTheme.h"
#import "BYDThemeManager.h"

static NSString *fontNameKey = @"fontNameKey";
@implementation UIFont (theme)
//@dynamic fontName;
- (void)setFontName:(NSString *)fontName {
    
    objc_setAssociatedObject(self, &fontNameKey,fontName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)fontName {
    
    return objc_getAssociatedObject(self, &fontNameKey);
}

+ (UIFont *)fontWithKey:(NSString *)fontkey container:(id)view {
    
    UIFont *font = [UIFont systemFontOfSize:[[[BYDThemeManager getCurrentThemeFontData] objectForKey:fontkey] floatValue]];
    if (!font) {
        
        return [UIFont systemFontOfSize:16];
    }
    font.fontName = fontkey;
    
    UIView *vie = view;
    vie.fontName = fontkey;
    return font;
}

@end
