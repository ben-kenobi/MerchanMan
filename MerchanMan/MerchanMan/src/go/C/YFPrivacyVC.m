


//
//  YFPrivacyVC.m
//  MerchanMan
//
//  Created by yf on 2019/4/26.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFPrivacyVC.h"

@interface YFPrivacyVC ()

@end

@implementation YFPrivacyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用许可和隐私条款";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:iURL(@"https://ben-kenobi.github.io/MerchanMan/blog/%E9%9A%90%E7%A7%81%E6%94%BF%E7%AD%96%E6%9D%A1%E6%AC%BE/")];
    [self.webView loadRequest:request];
}



@end
