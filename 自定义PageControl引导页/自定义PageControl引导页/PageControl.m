//
//  PageControl.m
//  自定义PageControl引导页
//
//  Created by yyl on 15/11/11.
//  Copyright © 2015年 fssj. All rights reserved.
//

/********************
 
 在声明property属性后，有2种实现选择
 @synthesize
 
 编译器期间，让编译器自动生成getter/setter方法。
 当有自定义的存或取方法时，自定义会屏蔽自动生成该方法
 
 @dynamic
 告诉编译器，不自动生成getter/setter方法，避免编译期间产生警告
 然后由自己实现存取方法
 或存取方法在运行时动态创建绑定：主要使用在CoreData的实现NSManagedObject子类时使用，由Core Data框架在程序运行的时动态生成子类属性
 *************************/

/*
 //UIView常用的一些方法小记之setNeedsDisplay和setNeedsLayout
 //http://blog.sina.com.cn/s/blog_a573f7990101cdpe.html
 
 */

#import "PageControl.h"
#define KDotDiameter 10.0  // dot的直径
#define KDotSpacer 10.0 // 间距
@implementation PageControl
@synthesize currentPage;
@synthesize numberOfPage;
@synthesize delegate;

// setter and gettet function
-(NSInteger)currentPage
{
    return _currentPage;
}
-(void)setCurrentPage:(NSInteger)page
{
    _currentPage = MIN(MAX(0, page), _numberOfPage-1);
    [self setNeedsDisplay];//
}

-(NSInteger)numberOfPage
{
    return _numberOfPage;
    
}
-(void)setNumberOfPage:(NSInteger)pages
{
    _numberOfPage = MAX(0,pages);
    _currentPage = MIN(MAX(0, _currentPage), _numberOfPage);
    
    // setNeedsDisplay 会异步调用 (void)drawRect:(CGRect)rect
    [self setNeedsDisplay];
}

//
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        //设置默认颜色
        self.backgroundColor = [UIColor clearColor];
        self.dotCurrentPageColor =[UIColor redColor];
        self.dotOtherPageColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //画出dot
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true);// 抗锯齿
    
    CGRect currentRect = self.bounds;
    //总宽度
    CGFloat dotsWidth = self.numberOfPage*KDotDiameter + MAX(0, self.numberOfPage-1)*KDotSpacer;;
    
    // CGRectGetMidX表示得到一个frame中心点的X坐标，CGRectGetMidY表示得到一个frame中心点的Y坐标
    CGFloat x = CGRectGetMidX(currentRect)-dotsWidth/2;
    CGFloat y = CGRectGetMidY(currentRect)-KDotDiameter/2;
    
    for (int i =0; i<_numberOfPage; i++) {
        CGRect circleRect = CGRectMake(x, y, KDotDiameter, KDotDiameter);
        if (i == _currentPage) {
            // CGContextSetFillColorWithColor 填充实心颜色
            CGContextSetFillColorWithColor(context, self.dotCurrentPageColor.CGColor);
        }else{
            CGContextSetFillColorWithColor(context, self.dotOtherPageColor.CGColor);
        }
        //画出圆形 FillEllipse：填充椭圆
        CGContextFillEllipseInRect(context, circleRect);
        
        // x的位置动态偏移
        x += KDotDiameter + KDotSpacer;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.delegate) return;
    // 获取点击位置
    CGPoint touchPoint  = [[[event touchesForView:self] anyObject] locationInView:self];
    NSLog(@"touchPoint-----%@",NSStringFromCGPoint(touchPoint));
    
    // 设置pagecontrol的可以响应事件的最大X
    CGFloat dotMaxSpanX = self.numberOfPage*(KDotSpacer + KDotDiameter);
    CGFloat dotMaxSpanY = KDotDiameter + KDotSpacer;
    
    CGRect currentRect = self.bounds;
    CGFloat x = touchPoint.x + dotMaxSpanX/2 - CGRectGetMidX(currentRect);
    CGFloat y = touchPoint.y + dotMaxSpanY/2 - CGRectGetMidY(currentRect);
    
    if ((x<0) || (x>dotMaxSpanX) || (y<0) || (y>dotMaxSpanY)) return;
    
    self.currentPage = floor(x/(KDotSpacer+KDotDiameter));
    if ([self.delegate respondsToSelector:@selector(pageControlPageDidChange:)])
    {
        //[self.delegate pageControlPageDidChange:self];
    }

    
}

@end
