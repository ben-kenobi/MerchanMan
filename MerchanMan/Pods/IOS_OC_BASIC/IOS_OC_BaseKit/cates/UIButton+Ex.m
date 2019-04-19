//
//  UIButton+Ex.m
//  BatteryCam
//
//  Created by yf on 2017/8/5.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "UIButton+Ex.h"
//#import <AudioToolbox/AudioToolbox.h>
//void AudioServicesPlaySystemSoundWithVibration(int, id, NSDictionary *);
//void AudioServicesStopSystemSound(int);
@implementation UIButton(Ex)

+(instancetype)btnWithImg:(UIImage *)img diableColor:(UIColor *)color{
    UIButton*  btn=[[self alloc]init];
    [btn setImage:img forState:0];
    [btn setImage:[img imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)] forState:UIControlStateDisabled];
    [[btn imageView] setTintColor:color];
    return btn;
}

+(instancetype)btnWithImg:(UIImage *)img hlColor:(UIColor *)color{
    UIButton*  btn=[[self alloc]init];
    [btn setImage:img forState:0];
    [btn setImage:[img imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)] forState:UIControlStateHighlighted];
    [[btn imageView] setTintColor:color];
    return btn;
}
+(instancetype)btnWithImg:(UIImage *)img hlImg:(UIImage *)hlimg{
    UIButton *btn = [[self alloc]init];
    [btn setImage:img forState:0];
    [btn setImage:hlimg forState:UIControlStateHighlighted];
    [btn sizeToFit];
    return btn;
}
+(instancetype)btnWithImg:(UIImage *)img selImg:(UIImage *)selimg{
    UIButton *btn = [[self alloc]init];
    [btn setImage:img forState:0];
    [btn setImage:selimg forState:UIControlStateSelected];
    btn.adjustsImageWhenHighlighted=NO;
    [btn sizeToFit];
    return btn;
}
+(instancetype)btnWithImg:(UIImage *)img hlImg:(UIImage *)hlimg selImg:(UIImage *)selimg{
    UIButton *btn = [[self alloc]init];
    [btn setImage:img forState:0];
    [btn setImage:selimg forState:UIControlStateSelected];
    [btn setImage:hlimg forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted=hlimg;
    [btn sizeToFit];
    return btn;
}

-(BOOL)isHighlighted{
    return [super isHighlighted];
}




-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    //判断device是否大于iphone7，iphone7以上才支持反馈震动，<2的为iphone6s或以下
//    NSInteger type=[[UIDevice.currentDevice valueForKey:@"_feedbackSupportLevel"] integerValue];
//
//    if(iVersion>=10&&type>=2){
//        static UIImpactFeedbackGenerator *gen;
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            gen = [[UIImpactFeedbackGenerator alloc]initWithStyle:(UIImpactFeedbackStyleMedium)];
//        });
//        [gen impactOccurred];
//    }else{
//        static NSMutableDictionary *dictionary ;
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            dictionary = [NSMutableDictionary dictionary];
//            // 可以自己设定震动间隔与时常（毫秒）
//            // 是否生效, 时长, 是否生效, 时长……
//            NSArray *pattern = @[@YES, @50, @NO, @1];
//            
//            dictionary[@"VibePattern"] = pattern; // 模式
//            dictionary[@"Intensity"] = @.5; // 强度（测试范围是0.3～1.0）
//        });
//        AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dictionary);
//    }
    [super sendAction:action to:target forEvent:event];

}



@end
