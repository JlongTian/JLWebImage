//
//  JLApp.m
//  JLWebImage
//
//  Created by 张天龙 on 17/3/10.
//  Copyright © 2017年 张天龙. All rights reserved.
//

#import "JLApp.h"

@implementation JLApp
+ (instancetype)appWithDict:(NSDictionary *)dict
{
    JLApp *app = [[self alloc] init];
    [app setValuesForKeysWithDictionary:dict];
    return app;
}
@end
