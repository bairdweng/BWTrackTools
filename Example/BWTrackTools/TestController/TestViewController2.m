//
//  TestViewController2.m
//  BWAopTestDemo
//
//  Created by baird weng on 2020/1/15.
//  Copyright © 2020 baird weng. All rights reserved.
//

#import "TestViewController2.h"
#import <Masonry.h>
#import "TestCustomView.h"

@interface TestViewController2 () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TestViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TableView点击事件";
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"fuck_you"];

    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fuck_you" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test====%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
