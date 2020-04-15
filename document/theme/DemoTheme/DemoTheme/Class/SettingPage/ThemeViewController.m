//
//  ThemeViewController.m
//  DemoTheme
//
//  Created by zhangshaoyu on 2018/11/26.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"主题";
    //
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    //
    NSString *fileStyle = [[NSBundle mainBundle] pathForResource:@"ThemeStyleBlue" ofType:@"plist"];
    NSDictionary *dictStyle = [NSDictionary dictionaryWithContentsOfFile:fileStyle];
    NSLog(@"dictStyle = %@", dictStyle);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSString *title = self.array[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *message = [NSString stringWithFormat:@"确定修改主题为：%@？", self.array[indexPath.row]];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改主题" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消修改主题");
    }];
    [alertController addAction:actionCancel];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定修改主题");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTheme" object:@(indexPath.row)];
    }];
    [alertController addAction:actionConfirm];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"默认", @"黑夜", @"红色", @"蓝色", @"绿色"];
    }
    return _array;
}

@end
