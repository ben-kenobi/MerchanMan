

//
//  YFCustTabBarItem.m
//  BatteryCam
//
//  Created by yf on 2017/9/12.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "YFCustTabBarItem.h"
#import "YFCate.h"
@implementation YFCustTabBarItem

-(void)setBadgeValue:(NSString *)badgeValue{
    [super setBadgeValue:badgeValue];
    if(!badgeValue) return;
    UITabBarController *vc = [self valueForKey:@"target"];
    if(!vc) return;
    
    
    for(UIView *subv in vc.tabBar.subviews){
        if([subv isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            for(UIView *subv2 in subv.subviews){
                if([subv2 isKindOfClass:NSClassFromString(@"_UIBadgeView")]){
                    for(UIView *subv3 in subv2.subviews){
                        if([subv3 isKindOfClass:[UIImageView class]]){
                            UIImageView *iv = (UIImageView *)subv3;
                            iv.image=img(@"personal_red_point_con");
                            [iv mas_remakeConstraints:^(MASConstraintMaker *make) {
                                make.leading.equalTo(@1.5);
                                make.centerY.equalTo(@-3.5);
                            }];
                        }
                    }
                }
            }
        }
    }
}

@end
