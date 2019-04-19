//
//  UIImage+Ex.m
//Created by apple on 17/07/21.
//

#import "UIImage+Ex.h"
#import "YFCate.h"
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import<QuartzCore/QuartzCore.h>
#import<Accelerate/Accelerate.h>

CGMutablePathRef shapePath(CGRect rect,NSInteger count,NSInteger step,NSInteger multi,CGFloat froma){
    if(!count) return 0;
    
    CGSize size=rect.size;
    CGPoint p=rect.origin;
    CGFloat cx=size.width*.5+p.x,cy=size.height*.5+p.y,
    rad=MIN(size.width,size.height)*.5;
    CGMutablePathRef path=CGPathCreateMutable();
    CGMutablePathRef patharc=CGPathCreateMutable();
    
    CGFloat from=froma,to=from,gap=2*M_PI/count;
    CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
    CGPoint cur=CGPathGetCurrentPoint(patharc);
    CGPathMoveToPoint(path, 0, cur.x, cur.y);
    
    for(int i=1;i<=step;i++){
        
        to=from+gap*multi;
        CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
        cur=CGPathGetCurrentPoint(patharc);
        CGPathAddLineToPoint(path, 0, cur.x, cur.y);
        from=to;
        
        if(!(i*multi%count)){
            to=from+gap;
            CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
            cur=CGPathGetCurrentPoint(patharc);
            CGPathMoveToPoint(path, 0, cur.x, cur.y);
            from=to;
        }
    }
    CGPathRelease(patharc);
    return path;
    
}

@implementation UIImage (Ex)

+(instancetype)shapeImgWithSize:(CGSize)size color:(UIColor *)color count:(NSInteger)count multi:(NSInteger)multi step:(NSInteger)step drawType:(int)type{
    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path= shapePath((CGRect){0,0,size}, count, step, multi,0);
    CGContextAddPath(con,path);
    CGPathRelease(path);
    [color set];
    CGContextDrawPath(con, type);
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (instancetype)img4Color:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)img4Color:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,iScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (instancetype)roundStretchImg4Color:(UIColor *)color w:(CGFloat)w {
    CGRect rect = CGRectMake(0, 0, w, w);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,iScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, w*.5, w*.5, w*0.5, 0, 2 * M_PI, 0);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image.resizableStretchImg;
}
+ (instancetype)roundStretchImg4Color:(UIColor *)color w:(CGFloat)w withBorder:(UIColor *)boderColor{
    CGRect rect = CGRectMake(0, 0, w, w);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,iScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, w*.5, w*.5, w*0.5, 0, 2 * M_PI, 0);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [boderColor CGColor]);
    CGContextFillRect(context, rect);
    CGContextAddArc(context, w*.5, w*.5, w*0.5-1, 0, 2 * M_PI, 0);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image.resizableStretchImg;
}
+ (instancetype)dotImg4Color:(UIColor *)color rad:(CGFloat)rad imgSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,iScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, size.width*.5, size.height*.5, rad, 0, 2 * M_PI, 0);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(instancetype)img4CVPixel:(CVPixelBufferRef)buf{
    UIImage *img = [UIImage imageWithCIImage:[CIImage imageWithCVPixelBuffer:buf]];
    CVPixelBufferRelease(buf);
    return img;
}

+(instancetype)imgFromV:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    [view.layer renderInContext:con];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(void)imgToCVPixel:(CVPixelBufferRef *)bufp{
    NSDictionary *options = @{
                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
                              };

    CIContext *context = [CIContext contextWithOptions:options];
    CVPixelBufferCreate(kCFAllocatorDefault, self.w,
                        self.h,  kCVPixelFormatType_32BGRA,0,
                        bufp);
    [context render:[CIImage imageWithCGImage:self.CGImage] toCVPixelBuffer:*bufp];
}


- (CVPixelBufferRef) pixelBufferRef
{
    
    CGImageRef image = self.CGImage;
    NSDictionary *options = @{
                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
                              };
    CVPixelBufferRef pxbuffer = NULL;
    
    CGFloat frameWidth = CGImageGetWidth(image);
    CGFloat frameHeight = CGImageGetHeight(image);
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32BGRA,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 frameWidth,
                                                 frameHeight,
                                                 8,
                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0,
                                           0,
                                           frameWidth,
                                           frameHeight),
                       image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}



- (unsigned char *) convertToBMRGBA8:(int *)oWidth oHeight:(int *)oHeight {
    
    CGImageRef imgRef = self.CGImage;
    
    // Create a bitmap context to draw the uiimage into
    CGContextRef context = [UIImage newBMRGBA8ContextFrom:imgRef];
    
    if(!context) {
        return NULL;
    }
    
    size_t width = CGImageGetWidth(imgRef);
    size_t height = CGImageGetHeight(imgRef);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the context to get the raw image data
    CGContextDrawImage(context, rect, imgRef);
    
    // Get a pointer to the data
    unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
    // Copy the data and release the memory (return memory allocated with new)
    size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    size_t bufferLength = bytesPerRow * height;
    *oWidth = (int)(bytesPerRow / 4);
    *oHeight = (int)height;
    
    unsigned char *newBitmap = NULL;
    
    if(bitmapData) {
        newBitmap = (unsigned char *)malloc(sizeof(unsigned char) * bytesPerRow * height);
        
        if(newBitmap) {    // Copy the data
            for(int i = 0; i < bufferLength; ++i) {
                newBitmap[i] = bitmapData[i];
            }
        }
        
        free(bitmapData);
        
    } else {
        NSLog(@"Error getting bitmap pixel data\n");
    }
    
    CGContextRelease(context);
    
    return newBitmap;
}

+ (CGContextRef) newBMRGBA8ContextFrom:(CGImageRef) imgRef {
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData;
    
    
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    
    size_t width = CGImageGetWidth(imgRef);
    size_t height = CGImageGetHeight(imgRef);
    
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!colorSpace) {
        NSLog(@"Error allocating color space RGB\n");
        return NULL;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if(!bitmapData) {
        NSLog(@"Error allocating memory for bitmap\n");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    //Create bitmap context
    
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedLast);    // RGBA
    if(!context) {
        free(bitmapData);
        NSLog(@"Bitmap context not created");
    }
    
    CGColorSpaceRelease(colorSpace);

    return context;
}

+ (instancetype) imgFromBMBuf:(unsigned char *) buffer
                                withWidth:(int) width
                               withHeight:(int) height {
    
    
    size_t bufferLength = width * height * 4;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    if(colorSpaceRef == NULL) {
        NSLog(@"Error allocating color space");
        CGDataProviderRelease(provider);
        return nil;
    }
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef iref = CGImageCreate(width,
                                    height,
                                    bitsPerComponent,
                                    bitsPerPixel,
                                    bytesPerRow,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,    // data provider
                                    NULL,        // decode
                                    YES,            // should interpolate
                                    renderingIntent);
    
    uint32_t* pixels = (uint32_t*)malloc(bufferLength);
    
    if(pixels == NULL) {
        NSLog(@"Error: Memory not allocated for bitmap");
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorSpaceRef);
        CGImageRelease(iref);
        return nil;
    }
    
    CGContextRef context = CGBitmapContextCreate(pixels,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 bitmapInfo);
    
    if(context == NULL) {
        NSLog(@"Error context not created");
        free(pixels);
    }
    
    UIImage *image = nil;
    if(context) {
        
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), iref);
        
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // Support both iPad 3.2 and iPhone 4 Retina displays with the correct scale
        if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
            float scale = [[UIScreen mainScreen] scale];
            image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
        } else {
            image = [UIImage imageWithCGImage:imageRef];
        }
        
        CGImageRelease(imageRef);
        CGContextRelease(context);
    }
    
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(iref);
    CGDataProviderRelease(provider);
    
    if(pixels) {
        free(pixels);
    }
    return image;
}


- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(instancetype)resizableStretchImg{
    CGFloat  w=self.size.width*.5;
    CGFloat h=self.size.height*.5;
    return [self resizableImageWithCapInsets:(UIEdgeInsets){h,w,h,w} resizingMode:UIImageResizingModeStretch];
}

-(instancetype)alwaysTemplate{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
-(instancetype)alwaysOrigin{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(instancetype)clipBy:(int)idx count:(int)count scale:(CGFloat)scale{
    CGFloat h=self.size.height*iScreen.scale,
    w=self.size.width/count*iScreen.scale;
    CGImageRef ci=CGImageCreateWithImageInRect([self CGImage], (CGRect){idx*w,0,w,h});
    UIImage *img= [UIImage imageWithCGImage:ci  scale:scale orientation:0];
    CGImageRelease(ci);
    return img;
}
-(UIImage *)renderWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, self.w,self.h);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,iScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextSetFillColorWithColor(context,  color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [img verticalMirroredImg];
}
-(UIImage *)verticalMirroredImg{
    return [UIImage imageWithCGImage:self.CGImage scale:iScreen.scale orientation:UIImageOrientationDownMirrored];
}
-(UIImage *)horizonMirroredImg{
    return [UIImage imageWithCGImage:self.CGImage scale:iScreen.scale orientation:UIImageOrientationUpMirrored];
}
-(UIImage *)scaleImg2size:(CGSize)size{
    
    CGRect tar={0,0,size};
    if(!CGSizeEqualToSize(self.size, size)){
        CGFloat scale=MIN(size.width /self.size.width, size.height/self.size.height);
        tar.size.width=self.size.width*scale;
        tar.size.height=self.size.height*scale;
        tar.origin.x=(size.width-tar.size.width)*.5;
        tar.origin.y=(size.height-tar.size.height)*.5;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
    [self drawInRect:tar];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



-(UIImage *)rotate4Angle:(CGFloat)angle{
    
    //将image转化成context
    
    //获取图片像素的宽和高
    size_t width =self.size.width*self.scale;
    size_t height =self.size.height*self.scale;
    
    //颜色通道为8因为0-255经过了8个颜色通道的变化
    //每一行图片的字节数因为我们采用的是ARGB/RGBA所以字节数为width * 4
    size_t bytesPerRow =width *4;
    
    //图片的透明度通道
    CGImageAlphaInfo info =kCGImageAlphaPremultipliedFirst;
    //配置context的参数:
    CGContextRef context =CGBitmapContextCreate(nil, width, height,8, bytesPerRow,CGColorSpaceCreateDeviceRGB(),kCGBitmapByteOrderDefault|info);
    
    if(!context) {
        return nil;
    }
    
    //将图片渲染到图形上下文中
    CGContextDrawImage(context,CGRectMake(0,0, width, height),self.CGImage);
    
    uint8_t* data = (uint8_t*)CGBitmapContextGetData(context);
    
    //旋转前的数据
    
    vImage_Buffer src = { data,height,width,bytesPerRow};
    
    //旋转后的数据
    
    vImage_Buffer dest= { data,height,width,bytesPerRow};
    
    //背景颜色
    Pixel_8888 backColor = {0,0,0,0};
    
    //填充颜色
    vImage_Flags flags = kvImageBackgroundColorFill;
    
    //旋转context
    vImageRotate_ARGB8888(&src, &dest,nil, -angle, backColor, flags);
    
    //将conetxt转换成image
    
    CGImageRef imageRef =CGBitmapContextCreateImage(context);
    
    UIImage* rotateImage =[UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    
    return rotateImage;
    
}


-(UIImage *)rotate4Angle2:(CGFloat)angle{
    CGFloat w = self.w*2,h=self.h*2;
    CGRect rect = CGRectMake(0, 0, w,h);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,iScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, w*.5, h*.5);
    CGContextRotateCTM(context, angle);
    CGContextTranslateCTM(context, w*-.5, h*-.5);
    [self drawInRect:CGRectMake(w*.25, h*.25, self.w, self.h)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



+(UIImage *)gifImgF:(NSString *)path{
    return [self gifImg:[NSData dataWithContentsOfFile:path]];
}


+(UIImage *)gifImg:(NSData *)data{
    
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
    
}



+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}








-(CGFloat)h{
    return self.size.height;
}
-(CGFloat)w{
    return self.size.width;
}


-(instancetype)roundImg:(CGFloat)ivW boderColor:(UIColor*)color borderW:(CGFloat)borderW{
    CGFloat w2=MIN(self.h, self.w);
    CGFloat r = ivW == 0 ? w2 : ivW;
    CGFloat scale = r/w2;
    CGFloat rad=r*0.5+borderW;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rad*2, rad*2), false, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    if (borderW>0){
        CGContextAddArc(con,rad,rad,rad,0, 2 * M_PI,0);
        [color setFill];
        CGContextDrawPath(con, kCGPathFill);
    }
    
    CGContextAddArc(con, rad, rad, r*0.5, 0, 2 * M_PI, 0);
    CGContextClip(con);
    [self drawInRect:CGRectMake(r-scale*self.w+borderW, r-scale*self.h+borderW, scale*self.w,scale*self.h)];
    
    
    UIImage* img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



-(instancetype) scale2w:(CGFloat)wid{
    CGSize size = CGSizeMake(wid, wid/self.w*self.h);
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(instancetype)scale2PreciseW:(CGFloat)wid{
    CGSize size = CGSizeMake(wid, wid/self.w*self.h);
    UIGraphicsBeginImageContextWithOptions(size, false, 1);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(instancetype)launchImg{
    NSDictionary* dict=iBundle.infoDictionary;
    NSArray *images = dict[@"UILaunchImages"] ;
    if(!images||!images.count) return nil;
    CGSize scrsize=iScreen.bounds.size;
    for (NSDictionary *dict in images) {
        CGSize size=CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(size, scrsize)) {
            return img(dict[@"UILaunchImageName"]);
        }
    }
    return nil;
}



+(instancetype)imgFromLayer:(CALayer*)layer{
    UIGraphicsBeginImageContextWithOptions(layer.size, false, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//将图片截取成方形，按比例计算xy起始点
-(instancetype)squareBy:(CGFloat)ratio{
    CGFloat w2=MIN(self.h, self.w);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w2,w2), false, 0);
    [self drawInRect:CGRectMake(-(self.w-w2)*ratio,-(self.h-w2)*ratio,self.w,self.h)];
    UIImage* img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(instancetype)convertAndroidPointNine{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.w-6, self.h-6), false, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextDrawImage(con, CGRectMake(-3, -3, self.size.width, self.size.height), self.CGImage);
    
    UIImage * img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [img resizableStretchImg];
}
+(void)generateVideoImage:(NSURL*)url cb:(void (^)(UIImage *img))cb
{
    AVURLAsset* asset=[AVURLAsset assetWithURL:url];
    AVAssetImageGenerator* generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform=true;
    
    CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
    
    AVAssetImageGeneratorCompletionHandler handle = ^(CMTime requestedTime, CGImageRef _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result != AVAssetImageGeneratorSucceeded) {
                NSLog(@"couldn't generate thumbnail, error:\(error)");
                return;
            }
            UIImage* img = [UIImage imageWithCGImage:image];
            cb(img);
        });
    };
    
    
    generator.maximumSize = CGSizeMake(320, 180);
    [generator generateCGImagesAsynchronouslyForTimes:@[[NSValue valueWithCMTime:thumbTime]]completionHandler:handle];
}

@end

@implementation CIImage(Ex)
-(CGFloat)h{
    return self.extent.size.height;
}
-(CGFloat)w{
    return self.extent.size.width;
}
@end
