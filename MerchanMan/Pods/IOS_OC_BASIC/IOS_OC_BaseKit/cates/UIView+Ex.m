//
//  UIView+Ex.m
//Created by apple on 17/07/21.
//

#import "UIView+Ex.h"
#import "YFCate.h"


@implementation UIView (Ex)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

-(CGFloat)w{
    return self.frame.size.width;
}
-(void)setW:(CGFloat)w{
    CGRect frame=self.frame;
    frame.size.width=w;
    self.frame=frame;
}

-(CGFloat)h{
    return self.frame.size.height;
}
-(void)setH:(CGFloat)h{
    CGRect frame=self.frame;
    frame.size.height=h;
    self.frame=frame;
}
-(CGPoint)innerCenter{
    return (CGPoint){self.w*.5,self.h*.5};
}

-(CGFloat)b{
    return CGRectGetMaxY(self.frame);
}
-(CGFloat)r{
    return CGRectGetMaxX(self.frame);
}

-(void)setB:(CGFloat)b{
    self.y=b-self.h;
}
-(void)setR:(CGFloat)r{
    self.x=r-self.w;
}



-(CGSize)size{
    return self.bounds.size;
}

-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}


-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
}

-(CGFloat)cx{
    return self.center.x;
}

-(void)setCx:(CGFloat)cx{
    CGPoint center=self.center;
    center.x=cx;
    self.center=center;
}


-(CGFloat)cy{
    return self.center.y;
}

-(void)setCy:(CGFloat)cy{
    CGPoint center=self.center;
    center.y=cy;
    self.center=center;
}


-(CGFloat)icx{
    return self.innerCenter.x;
}



-(CGFloat)icy{
    return self.innerCenter.y;
}

-(void)setB2:(CGFloat )b{
    CGRect frame=self.frame;
    frame.size.height=b-frame.origin.y;
    self.frame=frame;
}
-(void)setR2:(CGFloat )r{
    CGRect frame=self.frame;
    frame.size.width=r-frame.origin.x;
    self.frame=frame;
}
-(void)setX2:(CGFloat )x{
    CGRect frame=self.frame;
    frame.size.width=frame.origin.x-x+frame.size.width;
    self.frame=frame;
}
-(void)setY2:(CGFloat )y{
    CGRect frame=self.frame;
    frame.size.height=frame.origin.y-y+frame.size.height;
    self.frame=frame;
}


+(instancetype)viewWithColor:(UIColor *)color{
    UIView *v=[[self alloc]init];
    v.backgroundColor=color;
    return v;
}



UIView *layoutViewWithSize(UIView *sup,NSArray *subs,NSInteger colNum,BOOL veritcalFull,CGSize size){
    for(UIView *v in subs){
        v.size=size;
    }
    return layoutView(sup, subs, colNum, veritcalFull);
}

UIView *layoutView(UIView *sup,NSArray *subs,NSInteger colNum,BOOL veritcalFull){
    return layoutViewWithParam(sup,subs,colNum,veritcalFull,NO,NO,-1);
}

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
UIView *layoutViewWithParam(UIView *sup,NSArray *subs,NSInteger colNum,bool veritcalFull,bool sizeToFit,bool horizonScrollable,CGFloat horgap){
    if(!subs.count||!colNum) return 0;
    if(colNum>subs.count)
        colNum=subs.count;
    if([sup isKindOfClass:[UIScrollView class]]){
        UIView *content=[[UIView alloc] init];
        [sup addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
            if(!horizonScrollable)
                make.width.equalTo(sup);
        }];
        sup=content;
        
    }
    
    UIView *lastv;
    NSInteger i;
    NSMutableArray *ary=[NSMutableArray arrayWithCapacity:colNum+1];
    NSMutableArray *vary=[NSMutableArray array];
    for( i=0;i<subs.count;i++){
        NSInteger row=i/colNum,col=i%colNum;
        if(ary.count<col+1){
            UIView *gap=[[UIView alloc] init];
            [sup addSubview:gap];
            [gap mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(lastv?lastv.mas_trailing:@0);
                if(col)
                    make.width.equalTo([ary[col-1] mas_width]);
                else if(horgap>0)
                    make.width.equalTo(@(horgap));
            }];
            [ary addObject:gap];
        }
        if((vary.count<row+1)){
            UIView *gap=[[UIView alloc] init];
            [sup addSubview:gap];
            [gap mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastv?lastv.mas_bottom:@0);
                if(veritcalFull&&row)
                    make.height.equalTo([vary[row-1] mas_height]);
                else if(!veritcalFull)
                    make.height.equalTo([ary[0] mas_width]);
            }];
            [vary addObject:gap];
            
        }
        
        UIView *v=subs[i];
        [sup addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo([ary[col] mas_trailing]);
            make.top.equalTo([vary[row] mas_bottom]);
            if(!sizeToFit){
                make.width.equalTo(@(v.w));
                make.height.equalTo(@(v.h));
            }
        }];
        lastv=v;
        
        if(col==colNum-1&&ary.count<col+2){
            UIView *gap=[[UIView alloc] init];
            [sup addSubview:gap];
            [gap mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo([ary[col] mas_width]);
                make.trailing.equalTo(@0);
                make.leading.equalTo(lastv.mas_trailing);
            }];
            [ary addObject:gap];
        }
    }
    if(veritcalFull){
        UIView *gap=[[UIView alloc] init];
        [sup addSubview:gap];
        [gap mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.top.equalTo(lastv.mas_bottom);
            make.height.equalTo([[vary lastObject] mas_height]);
        }];
        [vary addObject:gap];
        return gap;
    }
    
    [sup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(lastv.mas_bottom);
    }];
    return lastv;
}

-(void)measurePriority:(float)level hor:(BOOL)hor{
    UILayoutConstraintAxis axis = hor?UILayoutConstraintAxisHorizontal:UILayoutConstraintAxisVertical;
    [self setContentHuggingPriority:level forAxis:axis];
    [self setContentCompressionResistancePriority:level forAxis:axis];
}
@end












@implementation CALayer (Ex)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

-(CGFloat)w{
    return self.frame.size.width;
}
-(void)setW:(CGFloat)w{
    CGRect frame=self.frame;
    frame.size.width=w;
    self.frame=frame;
}

-(CGFloat)h{
    return self.frame.size.height;
}
-(void)setH:(CGFloat)h{
    CGRect frame=self.frame;
    frame.size.height=h;
    self.frame=frame;
}
-(CGPoint)innerCenter{
    return (CGPoint){self.w*.5,self.h*.5};
}

-(CGFloat)b{
    return CGRectGetMaxY(self.frame);
}
-(CGFloat)r{
    return CGRectGetMaxX(self.frame);
}

-(void)setB:(CGFloat)b{
    self.y=b-self.h;
}
-(void)setR:(CGFloat)r{
    self.x=r-self.w;
}



-(CGSize)size{
    return self.bounds.size;
}

-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}


-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
}

-(CGFloat)cx{
    return self.position.x;
}

-(void)setCx:(CGFloat)cx{
    CGPoint center=self.position;
    center.x=cx;
    self.position=center;
}


-(CGFloat)cy{
    return self.position.y;
}

-(void)setCy:(CGFloat)cy{
    CGPoint center=self.position;
    center.y=cy;
    self.position=center;
}


-(CGFloat)icx{
    return self.innerCenter.x;
}



-(CGFloat)icy{
    return self.innerCenter.y;
}


-(CGFloat)anchorX{
    return self.anchorPoint.x;
}
-(void)setAnchorX:(CGFloat)anchorX{
    self.anchorPoint=CGPointMake(anchorX, self.anchorY);
}
-(CGFloat)anchorY{
    return self.anchorPoint.y;
}
-(void)setAnchorY:(CGFloat)anchorY{
    self.anchorPoint=CGPointMake(self.anchorX, anchorY);
}

-(void)setAnchor:(CGFloat)x y:(CGFloat)y{
    self.anchorPoint=CGPointMake(x, y);
}


-(void)setB2:(CGFloat )b{
    CGRect frame=self.frame;
    frame.size.height=b-frame.origin.y;
    self.frame=frame;
}
-(void)setR2:(CGFloat )r{
    CGRect frame=self.frame;
    frame.size.width=r-frame.origin.x;
    self.frame=frame;
}
-(void)setX2:(CGFloat )x{
    CGRect frame=self.frame;
    frame.size.width=frame.origin.x-x+frame.size.width;
    self.frame=frame;
}
-(void)setY2:(CGFloat )y{
    CGRect frame=self.frame;
    frame.size.height=frame.origin.y-y+frame.size.height;
    self.frame=frame;
}









@end
