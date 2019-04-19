//
//  UIView+LSCore.h
//  BatteryCam
//
//  Created by ocean on 2018/3/30.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LSCore)
/**
 *  设置部分圆角(绝对布局)
 *
 *  corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  radii 需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii viewRect:(CGRect)rect;

@end
