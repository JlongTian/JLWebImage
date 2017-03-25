//
//  JLOperation.m
//  
//
//  Created by 张天龙 on 17/3/10.
//  Copyright © 2017年. All rights reserved.
//

#import "JLWebImageOperation.h"
#import "JLWebImageManager.h"


@implementation JLWebImageOperation

- (void)main{
    
    @autoreleasepool {
        
        JLWebImageManager *manager = [JLWebImageManager sharedWebImageManager];
        
        // 1.0 下载图片
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_url]];
        
        // 2.0 数据加载失败或者被取消了
        if (data == nil || self.isCancelled) {
            
            // 移除操作
            [manager.operations removeObjectForKey:_url];
            return;
            
        }
        
        // 3.0 存到字典中
        UIImage *image = [UIImage imageWithData:data];
        manager.images[_url] = image;
        
        // 4.0 回到主线程显示图片
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _img.image = image;
        }];
        
        // 5.0 将图片文件数据写入沙盒中
        [data writeToFile:_file atomically:YES];
        
        // 6.0 移除操作
        [manager.operations removeObjectForKey:_url];
        
    }
    
}
@end
