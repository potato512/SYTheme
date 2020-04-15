//
//  Header.h
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/11/26.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark - 字体颜色

/// 字体大小
#define kFontSize(size) [UIFont systemFontOfSize:(size)]
/// 粗字体大小
#define kFontBoldSize(size) [UIFont boldSystemFontOfSize:(size)]

/// 设置颜色
#define UIColorRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

/// 设置颜色示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// 设置颜色与透明度示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

/// 随机颜色
#define UIColorRandom [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]




#endif /* Header_h */
