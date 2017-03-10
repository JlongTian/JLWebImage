//
//  JLApp.h
//  JLWebImage
//
//  Created by 张天龙 on 17/3/10.
//  Copyright © 2017年 张天龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLApp : NSObject
/**
 图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 下载量
 */
@property (nonatomic, copy) NSString *download;
/**
 名字
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)appWithDict:(NSDictionary *)dict;
@end
