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
    
    //如果此imageView正在下载图片就取消
    if (self.loadingURL) {
        
        NSOperation *operation = manager.operations[self.loadingURL];
        [operation cancel];
        
    }
    
    //先从内存缓存中取出图片
    UIImage *image = manager.images[url];
    
    if (image) { //内存中有图片
        
        self.image = image;
        
    }else{//内存中没有图片
        
        //获得Library/Caches文件夹
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        //获得文件名
        NSString *filename = [url lastPathComponent];
        //计算出文件的全路径
        NSString *file = [cachesPath stringByAppendingPathComponent:filename];
        //加载沙盒的文件数据
        NSData *data = [NSData dataWithContentsOfFile:file];
        
        if (data) { //直接利用沙盒中图片
            
            UIImage *image = [UIImage imageWithData:data];
            self.image = image;
            //存到字典中
            manager.images[url] = image;
            
        }else { //下载图片
            
            self.image = [UIImage imageNamed:placeholderImage];
            JLWebImageOperation *operation = manager.operations[url];
            
            if (operation == nil) { // 这张图片暂时没有下载任务
                
                //正在下载这张图片
                self.loadingURL = url;
                
                //创建下载任务
                operation = [[JLWebImageOperation alloc] init];
                operation.url = url;
                operation.img = self;
                operation.file = file;
                
                //添加到队列中
                [manager.queue addOperation:operation];
                //存放到字典中
                manager.operations[url] = operation;
                
            }
        
        }
        
    }
    
    
}
@end
