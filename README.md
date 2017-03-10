# JLWebImage
JLWebImage提供了异步下载图片的功能，已经做好了图片缓存，方法如下：
```objc
/**
 下载图片

 @param url 图片地址
 @param placeholderImage 占位图片名称
 */
- (void)jl_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage;
```
