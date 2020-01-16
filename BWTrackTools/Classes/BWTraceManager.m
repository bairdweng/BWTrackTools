//
//  BWTraceManager.m
//  BWAopTestDemo
//
//  Created by baird weng on 2020/1/15.
//  Copyright © 2020 baird weng. All rights reserved.
//

#import "BWTraceManager.h"
#import "BWBSAspects.h"
@import UIKit;

@interface BWTraceManager ()

@property (nonatomic, copy) NSDictionary *config;
@property (nonatomic, strong) BWTrackPageEventBlock pageEventBlock;
@property (nonatomic, strong) BWTrackEventBlock eventBlock;

@end

@implementation BWTraceManager

#pragma mark - 初始化
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)setUpWithConfig:(NSDictionary *)config withPageEvent:(BWTrackPageEventBlock)pageEvent withEvent:(BWTrackEventBlock)event {
    self.config = config;
    self.pageEventBlock = pageEvent;
    self.eventBlock = event;
    [self fire];
}
- (void)setUpWithConfigJsonFile:(NSString *)fileName withPageEvent:(BWTrackPageEventBlock)pageEvent withEvent:(BWTrackEventBlock)event {
    self.pageEventBlock = pageEvent;
    self.eventBlock = event;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *paths = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
        NSString *jsonStr = [NSString stringWithContentsOfFile:paths encoding:NSUTF8StringEncoding error:nil];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if (!err) {
            self.config = dic;
            [self fire];
        } else {
            NSLog(@"***********解析错误**************%@", err);
        }
    });
}


- (void)fire {
    if (![self configValid]) {
        NSLog(@"配置信息不合法");
        return;
    }
    [self trackEvent];
    [self trackViewAppear];
}

- (BOOL)configValid {
    if (self.config &&
        self.config.allKeys.count > 0 &&
        [self.config.allKeys containsObject:@"pages"] &&
        [self.config.allKeys containsObject:@"eventList"]) {
        return YES;
    }
    return NO;
}
#pragma mark-- 监控统计用户进入此界面的时长，频率等信息
- (void)trackViewAppear {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *pages = [self.config objectForKey:@"pages"];
        for (NSDictionary *pageItem in pages) {
            //获取类
            NSString *className = [pageItem objectForKey:@"pageName"];
            if (!className) return;
            NSDictionary *params = [pageItem objectForKey:@"params"];
            Class target = NSClassFromString(className);
            [target aspect_hookSelector:@selector(viewWillAppear:)
                            withOptions:BWBSAspectPositionBefore
                             usingBlock:^(id data) {
                                 [weakSelf trackPageStart:className withParams:params];
                             }
                                  error:nil];
            [target aspect_hookSelector:@selector(viewWillDisappear:)
                            withOptions:BWBSAspectPositionBefore
                             usingBlock:^(id data) {
                                 [weakSelf trackPageEnd:className withParams:params];
                             }
                                  error:nil];
        }
    });
}

#pragma mark--- 监控事件
- (void)trackEvent {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *eventList = [self.config objectForKey:@"eventList"];
        for (NSDictionary *eventItem in eventList) {
            //获取类
            NSString *className = [eventItem objectForKey:@"className"];
            if (!className) return;
            Class target = NSClassFromString(className);
            NSArray *events = [eventItem objectForKey:@"events"];
            for (NSDictionary *eventSubItem in events) {
                //方法名
                NSString *eventMethodName = eventSubItem[@"methodName"];
                NSDictionary *params = eventSubItem[@"params"];
                if (!eventMethodName) return;
                SEL seletor = NSSelectorFromString(eventMethodName);
                [target aspect_hookSelector:seletor
                                withOptions:BWBSAspectPositionBefore
                                 usingBlock:^(id<BWBSAspectInfo> aspectInfo) {
                                     [weakSelf trackEventClassName:className withEventName:eventMethodName withArguments:aspectInfo.arguments withParams:params];
                                 }
                                      error:nil];
            }
        }
    });
}

/// 页面统计开始
- (void)trackPageStart:(NSString *)pageName withParams:(NSDictionary *)params {
    if (self.pageEventBlock) {
        self.pageEventBlock(BWTrackPageEventTypeStart, pageName, params);
    }
}
/// 页面统计结束
- (void)trackPageEnd:(NSString *)pageName withParams:(NSDictionary *)params {
    if (self.pageEventBlock) {
        self.pageEventBlock(BWTrackPageEventTypeEnd, pageName, params);
    }
}
/// 事件统计。
- (void)trackEventClassName:(NSString *)className withEventName:(NSString *)eventName withArguments:(NSArray *)arguments withParams:(NSDictionary *)params {
    if (self.eventBlock) {
        self.eventBlock(className, eventName, arguments, params);
    }
}

@end
