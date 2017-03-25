//
//  UIImageView+JLWebCache.m
//  
//
//  Created by 张天龙 on 17/3/6.
//  Copyright © 2017年. All rights reserved.
//

#import "UIImageView+JLWebCache.h"
#import "JLWebImageManager.h"
#import "JLWebImageOperation.h"
#import <objc/runtime.h>

static char loadingURLKey;

@interface UIImageView ()

/**
 正在下载的图片地址
 */
@property (nonatomic,copy) NSString *loadingURL;
@end

@implementation UIImageView (JLWebCache)

- (void)setLoadingURL:(NSString *)loadingURL{
    objc_setAssociatedObject(self, &loadingURLKey, loadingURL, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)loadingURL{
    return objc_getAssociatedObject(self, &loadingURLKey);
}

- (void)jl_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage{
    
    JLWebImageManager *manager = [JLWebImageManager sharedWebImageManager];
    
    // 1.0 如果此imageView正在下载图片就取消
    if (self.loadingURL) {
        
        NSOperation *operation = manager.operations[self.loadingURL];
        [operation cancel];
        
    }
    
    // 2.0 先从内存缓存中取出图片
    UIImage *image = manager.images[url];
    
    if (image) { //2.1 内存中有图片
        
        self.image = image;
        
    }else{//2.2 内存中没有图片
        
        //2.2.1 获得Library/Caches文件夹
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        //2.2.2 获得文件名
        NSString *filename = [url lastPathComponent];
        
        //2.2.3 计算出文件的全路径
        NSString *file = [cachesPath stringByAppendingPathComponent:filename];
        
        //2.2.4 加载沙盒的文件数据
        NSData *data = [NSData dataWithContentsOfFile:file];
        
        if (data) { //2.2.4.1 直接利用沙盒中图片
            
            UIImage *image = [UIImage imageWithData:data];
            self.image = image;
            manager.images[url] = image;//存到字典中
            
        }else { //2.2.4.2  下载图片
            
            self.image = [UIImage imageNamed:placeholderImage];
            JLWebImageOperation *operation = manager.operations[url];
            
            if (operation == nil) { // 这张图片暂时没有下载任务
                
                
                //a. 正在下载这张图片
                self.loadingURL = url;
                
                //b. 创建下载任务
                operation = [[JLWebImageOperation alloc] init];
                operation.url = url;
                operation.img = self;
                operation.file = file;
                
                //c. 添加到队列中
                [manager.queue addOperation:operation];
                //d. 存放到字典中
                manager.operations[url] = operation;
                
            }
        
        }
        
    }
    
    
}
@end
