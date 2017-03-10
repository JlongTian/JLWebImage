//
//  JLWebCacheManger.h
//
//
//  Created by 张天龙 on 17/3/6.
//  Copyright © 2017年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLSingleton.h"

@interface JLWebImageManager : NSObject
/**
 内存缓存的图片
 */
@property (nonatomic, strong) NSMutableDictionary *images;
/**
 所有的操作对象
 */
@property (nonatomic, strong) NSMutableDictionary *operations;
/**
 队列对象
 */
@property (nonatomic, strong) NSOperationQueue *queue;

JLSingletonH(WebImageManager)

/**
 清除图片缓存
 */
- (void)clearMemories;

@end
