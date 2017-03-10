//
//  UIImageView+JLWebCache.h
//  
//
//  Created by 张天龙 on 17/3/6.
//  Copyright © 2017年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JLWebCache)

/**
 下载图片

 @param url 图片地址
 @param placeholderImage 占位图片名称
 */
- (void)jl_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage;

@end
