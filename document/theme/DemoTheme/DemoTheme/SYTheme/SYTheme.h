//
//  SYTheme.h
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/10/29.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SYThemeProtocol.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, SYThemeStyle)
{
    SYThemeStyleDefault = 0,
    SYThemeStyleNight = 1
};

@interface SYTheme : NSObject

+ (instancetype)shareTheme;

@property (nonatomic, assign) SYThemeStyle themeStyle;

/// 添加通知
- (void)addThemeListener:(id<SYThemeProtocol>)delegate;

/// 移除通知
- (void)removeThemeListener:(id<SYThemeProtocol>)delegate;

@end

NS_ASSUME_NONNULL_END


/*
 
 一、导航栏UINavigationController
 1、背景颜色
 2、字体
 （1）颜色
 （2）大小
 3、返回按钮
 4、右导航按钮
 二、视图UIView
 1、背景颜色
 三、标签UILabel
 1、字体
 （1）颜色
 （2）大小
 2、背景颜色
 四、图片UIImage
 五、页签UITabBarController
 1、背景颜色
 2、字体
 （1）大小
 （2）颜色
 3、图标
 （1）高亮时
 （2）常规时
 六、按钮UIButton
 1、图标
 2、背景颜色
 3、背景图标
 4、字体
 （1）颜色
 （2）大小

 换肤功能
 换肤功能，其实就是图片和颜色等资源的切换，也就是说你有几套皮肤，就提供对应的几套资源，当切换皮肤的时候，切换资源访问的路径并发出要换肤的通知，当前界面监听换肤的通知后再去刷新界面就完成了换肤的功能了。
 我们实现一个ThemeManager的主题管理类，应用的所有资源访问都通过这个类来实现统一管理，所有的主题基本上都是由颜色和资源（图片，音频，文本等）来决定的，所以换肤时只要更改主题颜色库（themeColors）和主题资源库（themeBundle）。
 Bundle是静态的，作为一个资源包是不参加项目编译的，也就是说，bundle包中不能包含可执行的文件，它仅仅是作为资源，被解析成为特定的2进制数据。
 
 主题管理类的基础功能如下：
 保存当前主题状态；
 提供主题切换的能力；
 在主题切换时将该时间抛出去；
 提供取image、color、font等的方法；
 
 对于没有显示的界面，更换主题是不需要通知的，因为在取资源时是根据当前主题取的，但是对于正在显示的界面，更换主题时就需要进行通知，让界面重新取资源后再重绘。由于这类通知是全局性的，因此应该使用NSNotification实现通知机制。
 
 
 */
