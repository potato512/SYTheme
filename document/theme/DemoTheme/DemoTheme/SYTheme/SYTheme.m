//
//  SYTheme.m
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/10/29.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "SYTheme.h"

static NSString *const kNotificationName = @"ThemeChangeNotification";

@interface SYTheme ()

@property (nonatomic, strong) NSDictionary *theme;

@end

@implementation SYTheme

+ (instancetype)shareTheme
{
    static SYTheme *theme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theme = [[self alloc] init];
    });
    return theme;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *themeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"theme"];
        if (themeName == nil) {
            themeName = @"default";
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist"];
        self.theme = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return self;
}

#pragma mark - setter

- (void)setThemeStyle:(SYThemeStyle)themeStyle
{
    [[NSUserDefaults standardUserDefaults] setInteger:themeStyle forKey:@"themeStyle"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 设置资源路径
    NSString *fileStyle = [[NSBundle mainBundle] pathForResource:@"" ofType:@"plist"];
    NSDictionary *dictStyle = [NSDictionary dictionaryWithContentsOfFile:fileStyle];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName object:dictStyle];
}

- (SYThemeStyle)themeStyle
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"themeStyle"];
}

/// 添加通知
- (void)addThemeListener:(id<SYThemeProtocol>)delegate
{
    if (delegate && [delegate respondsToSelector:@selector(themeStyleUpdate:)]) {
        [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(themeStyleUpdate:) name:kNotificationName object:nil];
    }
}

/// 移除通知
- (void)removeThemeListener:(id<SYThemeProtocol>)delegate
{
    if (delegate) {
        [[NSNotificationCenter defaultCenter] removeObserver:delegate];
    }
}

#pragma mark -

- (void)themeStypeWithImage:(NSString *)imageName complete:(void (^)(UIImage *image))complete
{
    // 耗时的操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 通过资源路径去访问
        NSString *imagePath = [NSString stringWithFormat:@"image/%@", imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        // 更新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(image);
        });
    });
}


- (UIImage *)imageForKey:(NSString *)key
{
    // 通过主题管理器使用资源
    NSString *imageName = [self.theme objectForKey:@"xxx_btn_background"];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

@end
