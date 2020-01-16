//
//  TestViewController1.m
//  BWAopTestDemo
//
//  Created by baird weng on 2020/1/15.
//  Copyright © 2020 baird weng. All rights reserved.
//

#import "TestViewController1.h"
#import <Masonry.h>
#import "TestCustomView.h"
@interface TestViewController1 ()

@end

@implementation TestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"按钮点击事件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    testBtn.backgroundColor = [UIColor redColor];
    [testBtn setTitle:@"无参数" forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(clickOntheBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@130);
        make.height.equalTo(@44);
        make.top.equalTo(@100);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *testBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [testBtn2 addTarget:self action:@selector(clickOntheBtnWithParams:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn2];
    [testBtn2 setTitle:@"带参数" forState:UIControlStateNormal];
    [testBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.equalTo(testBtn);
        make.top.equalTo(testBtn.mas_bottom).equalTo(@20);
    }];
    
    //组件
    TestCustomView *testView = [TestCustomView new];
    testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testView];
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(testBtn2.mas_bottom).equalTo(@20);
        make.height.equalTo(@200);
    }];
    
    //tap事件
    UIView *tapView = [[UIView alloc]init];
    tapView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:tapView];
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(testView.mas_bottom).equalTo(@20);
        make.height.equalTo(@60);
    }];
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(clickOntheTap)];
    [tapView addGestureRecognizer:tap];
    


    // Do any additional setup after loading the view.
}

/// 无参数
-(void)clickOntheBtn {

}

/// 带参数
-(void)clickOntheBtnWithParams:(id)sender {

}

/// tap
-(void)clickOntheTap {
    NSLog(@"tap");
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
