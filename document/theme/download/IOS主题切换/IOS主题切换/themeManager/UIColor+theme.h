//
//  UIColor+theme.h
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *colorNameKey = @"colorNameKey";

@interface UIColor (theme)

@property(strong, nonatomic) NSString *colorName;

+ (UIColor *)backColorWithKey:(NSString *)name container:(id)view;

+ (UIColor *)textColorWithKey:(NSString *)name container:(id)view;

+ (NSString *)hexadecimalFromUIColor:(UIColor*) color;

@end

NS_ASSUME_NONNULL_END
