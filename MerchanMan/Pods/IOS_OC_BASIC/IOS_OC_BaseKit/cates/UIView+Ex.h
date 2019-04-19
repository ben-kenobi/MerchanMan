//
//  UIView+Ex.h
//Created by apple on 17/07/21.
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    UIView *layoutViewWithSize(UIView *sup,NSArray *subs,NSInteger colNum,BOOL veritcalFull,CGSize size);
    
    UIView *layoutView(UIView *sup,NSArray *subs,NSInteger colNum,BOOL veritcalFull);
    
    /**
     
     @param sup layout所在的父view，可以是scrollview
     @param subs 被layout的子views
     @param colNum 排列的列数
     @param veritcalFull 是否垂直方向铺满，即垂直间距动态拉长
     @param sizeToFit 使用子view本身动态适配的size
     @param horizonScrollable 是否水平方向可滑动，只在sup为scrollview时生效
     @param horgap 水平方向间距
     @return 返回最后一个子views
     */
    UIView *layoutViewWithParam(UIView *sup,NSArray *subs,NSInteger colNum,bool veritcalFull,bool sizeToFit,bool horizonScrollable,CGFloat horgap);
#ifdef __cplusplus
}
#endif
    
@interface UIView (Ex)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat w;
@property (nonatomic,assign)CGFloat h;
@property (nonatomic,assign)CGFloat b;
@property (nonatomic,assign)CGFloat r;
@property (nonatomic,assign)CGFloat cx;
@property (nonatomic,assign)CGFloat cy;
@property (nonatomic,assign,readonly)CGPoint innerCenter;
@property (nonatomic,assign,readonly)CGFloat icx;
@property (nonatomic,assign,readonly)CGFloat icy;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;

-(void)setB2:(CGFloat )b;
-(void)setR2:(CGFloat )r;
-(void)setX2:(CGFloat )x;
-(void)setY2:(CGFloat )y;


-(void)measurePriority:(float)level hor:(BOOL)hor;
+(instancetype)viewWithColor:(UIColor *)color;

@end


@interface CALayer (Ex)
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat w;
@property (nonatomic,assign)CGFloat h;
@property (nonatomic,assign)CGFloat b;
@property (nonatomic,assign)CGFloat r;
@property (nonatomic,assign)CGFloat cx;
@property (nonatomic,assign)CGFloat cy;
@property (nonatomic,assign,readonly)CGPoint innerCenter;
@property (nonatomic,assign,readonly)CGFloat icx;
@property (nonatomic,assign,readonly)CGFloat icy;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;
@property (nonatomic,assign)CGFloat anchorX;
@property (nonatomic,assign)CGFloat anchorY;

-(void)setB2:(CGFloat )b;
-(void)setR2:(CGFloat )r;
-(void)setX2:(CGFloat )x;
-(void)setY2:(CGFloat )y;
-(void)setAnchor:(CGFloat) x y:(CGFloat)y;



@end
