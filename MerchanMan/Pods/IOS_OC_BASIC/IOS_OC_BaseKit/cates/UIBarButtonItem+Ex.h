//
//  UIBarButtonItem+Ex.h
//Created by apple on 17/07/21.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Ex)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action img:(UIImage *)img hlimg:(UIImage *)hlimg;
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action img:(UIImage *)img hlimg:(UIImage *)hlimg frame:(CGRect)frame;


+ (UIBarButtonItem *)initWithNormalImage:(UIImage *)image target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)initWithNormalImageBig:(UIImage *)image target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)initWithNormalImage:(UIImage *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
@end
