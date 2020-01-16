//
//  TestCustomView.m
//  BWAopTestDemo
//
//  Created by baird weng on 2020/1/15.
//  Copyright © 2020 baird weng. All rights reserved.
//

#import "TestCustomView.h"
#import <Masonry.h>

@implementation TestCustomView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        testBtn.backgroundColor = [UIColor yellowColor];
        [testBtn setTitle:@"---------组件-----" forState:UIControlStateNormal];
        [testBtn addTarget:self action:@selector(clickOntheBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:testBtn];
        [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@130);
            make.height.equalTo(@44);
            make.center.equalTo(self);
        }];
    }
    return self;
}

-(void)clickOntheBtn {
}

@end
