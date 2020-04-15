//
//  UIImage+SYTheme.h
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/10/29.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SYTheme)

/// @3x图片转@2x图片
- (UIImage *)scaledImageFrom3x;

@end

NS_ASSUME_NONNULL_END
