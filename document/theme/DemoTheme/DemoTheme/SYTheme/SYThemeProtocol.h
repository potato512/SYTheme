//
//  SYThemeProtocol.h
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/10/29.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SYThemeProtocol <NSObject>

- (void)themeStyleUpdate:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
