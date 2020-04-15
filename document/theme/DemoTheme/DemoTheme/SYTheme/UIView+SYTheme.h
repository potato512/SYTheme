//
//  UIView+SYTheme.h
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/10/29.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYTheme.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  主题切换block
 *
 *  @param state 当前主题状态(GNDayNightState)
 */
typedef void (^UIViewDayNight_themeChangeBlock)(SYThemeStyle state);


@interface UIView (SYTheme)

/**
 *  设置背景色的ID
 */
@property (nonatomic, strong) NSString *dn_backgroundColorID;
/**
 *  是否注册主题通知，YES == 注册主题通知，主题切换时
 *  dn_onDayNightStateHasChange: 会被调用
 */
@property (nonatomic, assign) BOOL dn_isNeedTheme;


/**
 *  子类通过复写该方法来做主题切换相关操作(切换图片，改变颜色等)
 *
 *  @param state 主题状态
 */
- (void)dn_onDayNightStateHasChange:(SYThemeStyle) state;

/**
 *  注册主题变化的block
 *
 *  @param themeChangeBlock 主题切换block
 */
- (void)dn_setThemeChangeBlock:(UIViewDayNight_themeChangeBlock)themeChangeBlock;


@end

NS_ASSUME_NONNULL_END
