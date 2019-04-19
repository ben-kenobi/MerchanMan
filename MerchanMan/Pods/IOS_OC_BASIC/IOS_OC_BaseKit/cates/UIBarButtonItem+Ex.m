//
//  UIBarButtonItem+Ex.m
//Created by apple on 17/07/21.
//

#import "UIBarButtonItem+Ex.h"
#import "YFCate.h"

@implementation UIBarButtonItem (Ex)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action img:(UIImage *)img hlimg:(UIImage *)hlimg{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:hlimg forState:UIControlStateHighlighted];
    btn.size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action img:(UIImage *)img hlimg:(UIImage *)hlimg frame:(CGRect)frame{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
//    btn.contentMode=UIViewContentModeCenter;
//    [btn setBackgroundImage:hlimg forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



+ (UIBarButtonItem *)initWithNormalImage:(UIImage *)image target:(id)target action:(SEL)action{
 
    return [self itemWithTarget:target action:action img:image hlimg:image frame:(CGRect){0,0,20,20}];
}


+ (UIBarButtonItem *)initWithNormalImageBig:(UIImage *)image target:(id)target action:(SEL)action{
    return [self itemWithTarget:target action:action img:image hlimg:image frame:(CGRect){0,0,35,35}];
}


+ (UIBarButtonItem *)initWithNormalImage:(UIImage *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height{
    return [self itemWithTarget:target action:action img:image hlimg:image frame:(CGRect){0,0,width,height}];
}



+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
    
}
@end
