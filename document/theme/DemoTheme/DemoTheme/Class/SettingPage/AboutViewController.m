//
//  AboutViewController.m
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/11/26.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"关于";
    
    [self setUI];
}

- (void)setUI
{
    if (self.label.superview == nil) {
        [self.view addSubview:self.label];
        self.label.frame = CGRectMake(20.0, 20.0, (self.view.frame.size.width - 40.0), (self.view.frame.size.height - 40.0));
    }
    self.label.text = @"theme主题修改示例demo。";
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor blackColor];
        _label.backgroundColor = [UIColor clearColor];
    }
    return _label;
}

@end
