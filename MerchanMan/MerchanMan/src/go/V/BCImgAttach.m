//
//  BCImgAttach.m
//  BatteryCam
//
//  Created by yf on 2017/11/7.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCImgAttach.h"

@interface BCImgAttach()

@end

@implementation BCImgAttach

+(NSAttributedString *)attStrWith:(UIImage *)img path:(NSString *)path{
    BCImgAttach *ata = [[BCImgAttach alloc]init];
    ata.path=path;
    ata.image=img;
    return [NSAttributedString attributedStringWithAttachment:ata];
}
-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    return CGRectMake(0, -3.5, lineFrag.size.height*4, lineFrag.size.height*4);
}

@end
