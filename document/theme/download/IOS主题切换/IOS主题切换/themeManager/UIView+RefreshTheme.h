//
//  UIView+RefreshTheme.h
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RefreshTheme)

@property(strong, nonatomic) NSString *colorName;// 背景色

@property(strong, nonatomic) NSString *textColorName;// 文本颜色

@property(strong, nonatomic) NSString *imageName;// 图片

@property(strong, nonatomic) NSString *fontName;// 字体

@end

NS_ASSUME_NONNULL_END
