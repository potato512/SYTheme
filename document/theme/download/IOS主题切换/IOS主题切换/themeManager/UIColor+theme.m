//
//  UIColor+theme.m
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UIColor+theme.h"
#import <objc/runtime.h>
#import "UIView+RefreshTheme.h"
#import "BYDThemeManager.h"

@implementation UIColor (theme)
//@dynamic colorName;
// setter
- (void)setColorName:(NSString *)colorName {
    
    objc_setAssociatedObject(self, &colorNameKey,colorName, OBJC_ASSOCIATION_COPY);
}
// getter
- (NSString *)colorName {
    
    return objc_getAssociatedObject(self, &colorNameKey);
}

+ (UIColor *)backColorWithKey:(NSString *)name container:(id)view {
    
    UIColor *color = [UIColor colorWithHexString:[[BYDThemeManager getCurrentThemeColorData] objectForKey:name]];
    
    if (!color) {
        
        return [UIColor colorWithHexString:name];
    }
#pragma mark - set
    UIView *vie =  view;
    vie.colorName = name;
    
    color.colorName = name;
    return color;
}


+ (UIColor *)textColorWithKey:(NSString *)name container:(id)view {
    
    UIColor *color = [UIColor colorWithHexString:[[BYDThemeManager getCurrentThemeColorData] objectForKey:name]];
    if (!color) {
        
        return [UIColor colorWithHexString:name];
    }
    // btn 、label
    UIView *vie = view;
    vie.textColorName = name;
    
    return color;
}

+ (UIColor *)colorWithHexString:(NSString *)color{
    
    return [self colorWithHexString:color alpha:1.0f];
}


/// 十六进制字符串获取颜色
/// @param color 16进制色值  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6){
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
   
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    
    //return colour;
}


/// 适配暗黑模式颜色   传入的UIColor对象
/// @param lightColor 普通模式颜色
/// @param darkColor 暗黑模式颜色
/*
系统的语义颜色以及系统颜色：这两种iOS13提供的动态颜色都会根据mode变化，帮助我们快速实现类似系统配色的适配，这里简单列举，大家感受一下～
LabelColor :文本颜色
secondaryLabelColor : 辅助内容的文本标签颜色
tertiaryLabelColor ：三级
linkColor: 超链接标签颜色
separatorColor/opaqueseparatorColor：分隔符（细边框或者分割线）
systembackgroundColor ：界面背景色
创建Dynamic Color
*/
+ (UIColor *)colorWithLightColor:(UIColor *)lightColor DarkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return lightColor;
            } else {
                return darkColor;
            }
        }];
    } else {
        return lightColor ? lightColor : (darkColor ? darkColor : [UIColor clearColor]);
    }
}

/// 适配暗黑模式颜色   颜色传入的是16进制字符串
/// @param lightColor 普通模式颜色
/// @param darkColor 暗黑模式颜色
+ (UIColor *)colorWithLightColorStr:(NSString *)lightColor DarkColor:(NSString *)darkColor{
    return [UIColor colorWithLightColor:[UIColor colorWithHexString:lightColor] DarkColor:[UIColor colorWithHexString:darkColor]];
}


/// 适配暗黑模式颜色   颜色传入的是16进制字符串 还有颜色的透明度
/// @param lightColor 普通模式颜色
/// @param lightAlpha 普通模式颜色透明度
/// @param darkColor 暗黑模式颜色透明度
/// @param darkAlpha 暗黑模式颜色
+ (UIColor *)colorWithLightColorStr:(NSString *)lightColor WithLightColorAlpha:(CGFloat)lightAlpha DarkColor:(NSString *)darkColor WithDarkColorAlpha:(CGFloat)darkAlpha{
    return [UIColor colorWithLightColor:[UIColor colorWithHexString:lightColor alpha:lightAlpha] DarkColor:[UIColor colorWithHexString:darkColor alpha:darkAlpha]];
}

+ (UIImage *)getdarkModeImage:(NSString *)imgName
             traitcollection:(UITraitCollection *)trait {
    
    if (@available(iOS 13.0, *)) {
        
        UIImage * imgs = [UIImage imageNamed:imgName inBundle:nil compatibleWithTraitCollection:[UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight]];
        
        [imgs.imageAsset registerImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_dark",imgName]] withTraitCollection:[UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark]];
        
        return [imgs.imageAsset imageWithTraitCollection:trait];
        
    }else{
        
        return [UIImage imageNamed:imgName];
    }
}

#pragma mark - uicolor - > 16进制
+ (NSString *)hexadecimalFromUIColor: (UIColor*) color {

if(CGColorGetNumberOfComponents(color.CGColor) < 4) {

const CGFloat *components =CGColorGetComponents(color.CGColor);

color = [UIColor colorWithRed:components[0]

green:components[0]

blue:components[0]

alpha:components[1]];

}

if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) !=kCGColorSpaceModelRGB) {

return [NSString stringWithFormat:@"#FFFFFF"];

}

NSString *r,*g,*b;

(int)((CGColorGetComponents(color.CGColor))[0]*255.0) == 0?(r =[NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]):(r= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]);

(int)((CGColorGetComponents(color.CGColor))[1]*255.0)== 0?(g = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]):(g= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]);

(int)((CGColorGetComponents(color.CGColor))[2]*255.0)== 0?(b = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]):(b= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]);

return [NSString stringWithFormat:@"#%@%@%@",r,g,b];

}

@end
