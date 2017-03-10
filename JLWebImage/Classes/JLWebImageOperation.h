//
//  JLOperation.h
//  
//
//  Created by 张天龙 on 17/3/10.
//  Copyright © 2017年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLWebImageOperation : NSOperation

/**
 图片地址
 */
@property (nonatomic,copy) NSString *url;

/**
 文件写入路径
 */
@property (nonatomic,copy) NSString *file;

/**
 需要获取图片的ImageView
 */
@property (nonatomic,weak) UIImageView *img;

@end
