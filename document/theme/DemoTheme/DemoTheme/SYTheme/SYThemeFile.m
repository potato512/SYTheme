//
//  SYThemeFile.m
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/11/27.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "SYThemeFile.h"

@interface SYThemeFile () <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation SYThemeFile

#pragma mark - 文件下载

- (NSURLSessionDownloadTask *)downloadTask
{
    if (_downloadTask == nil) {
        _downloadTask = [[NSURLSessionDownloadTask alloc] init];
//        _downloadTask.delegate = self;
    }
    return _downloadTask;
}

- (void)downloadTheme:(NSString *)urlString
{
    // 获取资源的Url
    NSURL *url = [NSURL URLWithString:urlString];
    // 创建NSSessionDownloadTask的抽象类执行下载
//    self.downloadTask = [self.session downloadTaskWithURL:url];
    [self.downloadTask resume];
}

/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    // 获取沙盒Documents路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接下载文件的文件名，形成绝对路径
    self.filePath = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    // 将文件移动到指定目录位置
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:self.filePath error:nil];
    // 准备执行解压方法
    [self onFileSelected:self.filePath];
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // 获取下载进度
    double progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"下载进度:%f",progress);
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

#pragma mark - 文件解压

- (void)onFileSelected:(NSString *)selectedPath
{
    NSURL *fileURL = [NSURL fileURLWithPath:selectedPath];
    NSString *fileNameComponent = fileURL.lastPathComponent;
    // 获取文件的扩展名
    NSString *extension = [[fileNameComponent pathExtension] lowercaseString];
    // 如果是zip类型的压缩包文件，则进行解压
    if ([extension isEqualToString:@"zip"]) {
        // 设置解压路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        NSString* unZipTo = documentPath;
        // 开始解压缩
        [self releaseZipFilesWithUnzipFileAtPath:self.filePath Destination:unZipTo];
    }
}
    
    
// 用到了SSZipArchive这个工具类。因为这个类是用C语言写的，所以在使用的时候需要在工程中添加libz.tbd库。
// 解压
- (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath
{
//    NSError *error;
//    // 如果解压成功
//    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath overwrite:YES password:nil error:&error delegate:self]) {
//        // 存储主题的色调
//        UserDefaultsWriteObj([BKTool getThemeColorWithDocName:self.model.siteId], @"mainColor");
//        UserDefaultsSynchronize;
//        // 重新加载页面样式
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view.alpha = 0;
//            self.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
//
//        } completion:^(BOOL finished) {
//            if ([SITEID integerValue] == 38) {
//                appDelegate.window.rootViewController = [[XYZhongBingTabBarController alloc] init];
//
//            } else {
//                appDelegate.window.rootViewController = [[BKMainTabBarController alloc] init];
//            }
//        }];
//    } else {
//        // 输出解压失败的错误问题
//        NSLog(@"%@",error);
//    }
}
    
    
@end
