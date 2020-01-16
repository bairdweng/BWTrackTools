//
//  BWTraceManager.h
//  BWAopTestDemo
//
//  Created by baird weng on 2020/1/15.
//  Copyright © 2020 baird weng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    BWTrackPageEventTypeStart,
    BWTrackPageEventTypeEnd
} BWTrackPageEventType;


/// 页面统计的Block pageName 页面名称;params 额外参数。
typedef void (^BWTrackPageEventBlock)(BWTrackPageEventType type,NSString *pageName, NSDictionary *params);
/// 事件统计的Block className 类名; eventName 方法名; arguments 方法参数;params 额外参数。
typedef void (^BWTrackEventBlock)(NSString *className, NSString *eventName, NSArray *arguments, NSDictionary *params);

@interface BWTraceManager : NSObject

+ (instancetype)share;
- (void)setUpWithConfig:(NSDictionary *)config withPageEvent:(BWTrackPageEventBlock)pageEvent withEvent:(BWTrackEventBlock)event;
- (void)setUpWithConfigJsonFile:(NSString *)fileName withPageEvent:(BWTrackPageEventBlock)pageEvent withEvent:(BWTrackEventBlock)event;

@end
