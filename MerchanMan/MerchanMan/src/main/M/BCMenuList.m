//
//  BCMenuList.m
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCMenuList.h"

@implementation BCMenuList

-(instancetype)init{
    if(self=[super init]){
        NSArray *ary = iRes4ary(@"MenuList.plist");
        for(NSDictionary *dict in ary){
            [self.menulist addObject:[BCMenuMod setDict:dict]];
        }
    }
    return self;
}


-(void)clickOn:(NSInteger)idx{
    [iAppDele.mainVC coverClick:YES];
    UIViewController *vc = [[NSClassFromString([self get:idx].vcName) alloc]init];
    if([vc respondsToSelector:@selector(setMenuMod:)]){
        [vc performSelector:@selector(setMenuMod:) withObject:[self get:idx]];
    }
    vc.title=[self get:idx].title;

//    [self get:idx].hasNews=NO;
   
    [UIViewController pushVC:vc];
}



-(NSInteger)count{
    return self.menulist.count;
}
-(BCMenuMod *)get:(NSInteger)idx{
    if(idx>=0&&idx<self.count)
        return self.menulist[idx];
    return nil;
}
-(void)setMsgNews:(NSInteger)count{
    for(BCMenuMod *mod in self.menulist){
        if([mod.title isEqualToString:NSLocalizedString(@"bc.common.settings",0)]){
            mod.hasNews=count>0;
            mod.newNotiCount=count;
        }
    }
}
iLazy4Ary(menulist, _menulist)

@end
