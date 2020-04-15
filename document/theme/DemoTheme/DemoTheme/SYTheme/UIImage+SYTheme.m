//
//  UIImage+SYTheme.m
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/10/29.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "UIImage+SYTheme.h"

@implementation UIImage (SYTheme)

/// @3x图片转@2x图片
- (UIImage *)scaledImageFrom3x
{
    float locScale = [UIScreen mainScreen].scale;
    
    float theRate = 2.0 / 3.0;
    UIImage *newImage = nil;
    
    CGSize oldSize = self.size;
    
    CGFloat scaledWidth = oldSize.width * theRate;
    CGFloat scaledHeight = oldSize.height * theRate;
    
    CGRect scaledRect = CGRectZero;
    scaledRect.size.width  = scaledWidth;
    scaledRect.size.height = scaledHeight;
    
    UIGraphicsBeginImageContextWithOptions(scaledRect.size, NO, locScale);
    
    [self drawInRect:scaledRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if (newImage == nil) {
        NSLog(@"could not scale image");
    }
    return newImage;
}

+ (UIImage *)imageWithDocumentoryName:(NSString *)documentoryName imageName:(NSString *)imageName
{
    // 如果文件名不存在或者文件名为空，则返回空
    if (!imageName || [imageName isEqualToString:@""]) {
        return nil;
    }
    
    // 获取图片完整路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *docPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@", documentoryName]];
    NSString *imgPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];
    //
    if ([[NSFileManager defaultManager] fileExistsAtPath:imgPath]) {
        // 如果文件存在，则返回对应文件
        return [UIImage imageWithContentsOfFile:imgPath];
    } else {
        // 否则获取本地的默认文件
        return [UIImage imageNamed:imageName];
    }
}
    
    
@end
