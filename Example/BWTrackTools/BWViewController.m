//
//  BWViewController.m
//  BWTrackTools
//
//  Created by baird weng on 01/16/2020.
//  Copyright (c) 2020 baird weng. All rights reserved.
//

#import "BWViewController.h"
#import "TestViewController1.h"
#import "TestViewController2.h"
#import <Masonry.h>
@interface BWViewController ()

@end

@implementation BWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn1 = [UIButton new];
      btn1.backgroundColor = [UIColor redColor];
      [btn1 addTarget:self action:@selector(clickOntheBtn1) forControlEvents:UIControlEventTouchUpInside];
      [btn1 setTitle:@"点击事件统计" forState:UIControlStateNormal];
      [self.view addSubview:btn1];
      [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.width.equalTo(@130);
          make.height.equalTo(@44);
          make.top.equalTo(@100);
          make.centerX.equalTo(self.view);
      }];

      UIButton *btn2 = [UIButton new];
      btn2.backgroundColor = [UIColor redColor];
      [btn2 addTarget:self action:@selector(clickOntheBtn2) forControlEvents:UIControlEventTouchUpInside];
      [btn2 setTitle:@"tableView事件统计" forState:UIControlStateNormal];
      [self.view addSubview:btn2];
      [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.width.height.centerX.equalTo(btn1);
          make.top.equalTo(btn1.mas_bottom).equalTo(@20);
      }];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)clickOntheBtn1 {
    [self.navigationController pushViewController:[[TestViewController1 alloc]init] animated:YES];
}
- (void)clickOntheBtn2 {
    [self.navigationController pushViewController:[[TestViewController2 alloc]init] animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
