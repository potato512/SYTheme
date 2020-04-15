//
//  UIImage+theme.h
//  iOS暗黑模式适配
//
//  Created by chenanyang on 2020/3/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (theme)

@property(strong, nonatomic) NSString *imageName;

+ (UIImage *)imageWithKey:(NSString *)name container:(id)view;

@end

NS_ASSUME_NONNULL_END
