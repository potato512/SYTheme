//
//  UIImage+theme.m
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UIImage+theme.h"
#import <objc/runtime.h>
#import "UIView+RefreshTheme.h"
#import "BYDThemeManager.h"

static NSString *imageNameKey = @"imageNameKey";

@implementation UIImage (theme)
@dynamic imageName;

- (void)setImageName:(NSString *)imageName {
    
    objc_setAssociatedObject(self, &imageNameKey,imageName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)imageName {
    
    return objc_getAssociatedObject(self, &imageNameKey);
}

+ (UIImage *)imageWithName:(NSString *)name {
    
    UIImage *image = [UIImage imageNamed:[[BYDThemeManager getCurrentThemeImageData] objectForKey:name]];
    if (!image) {
        
        return [UIImage imageNamed:name];
    }
    image.imageName = name;
    return image;
}

+ (UIImage *)imageWithKey:(NSString *)name container:(id)view {
    
    UIImage *image = [UIImage imageNamed:[[BYDThemeManager getCurrentThemeImageData] objectForKey:name]];
    if (!image) {
        
        return [UIImage imageNamed:name];
    }
    image.imageName = name;
    
    UIView *img = view;
    img.imageName = name;
    
    return image;
}

@end
