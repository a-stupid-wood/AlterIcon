//
//  ViewController.m
//  AlterIcon
//
//  Created by Admin on 2019/7/30.
//  Copyright © 2019 yzwl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = @[@"qiao",@"zhongdui",@"suidao"];
    [self.view addSubview:self.mainTableView];
}

#pragma mark - action
- (void)changeIconWithIconName:(NSString *)iconName{
    NSLog(@"%@",iconName);
    //    must be used from main thread only
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        //不支持动态更换icon
        return;
    }
    
    if ([iconName isEqualToString:@""] || !iconName) {
        iconName = nil;
    }
    [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"更换app图标发生错误了 ： %@",error);
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentify"];
    NSString *imageName = _dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = imageName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeIconWithIconName:_dataSource[indexPath.row]];
}

#pragma mark - lazy load
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.rowHeight = 44.0f;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.tableFooterView = [[UIView alloc] init];
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    }
    return _mainTableView;
}

@end
