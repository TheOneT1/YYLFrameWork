//
//  YYLProgressView.m
//  画ProgressView
//
//  Created by yyl on 15/11/12.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "YYLProgressView.h"

@implementation YYLProgressView

@synthesize trackTintColor = _trackTintColor;
@synthesize progressTintColor = _progressTintColor;
@synthesize progress=_progress;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.progressTintColor = [UIColor lightGrayColor];
        self.trackTintColor = [UIColor redColor];
    }
    return self;
}


// 画progress
- (void)drawRect:(CGRect)rect {
    // Drawing code
   
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    NSLog(@"context的宽----%f",CGRectGetHeight(rect));
    //抗锯齿
    //CGContextSetShouldAntialias(context, NO );
    // CGContextSetAllowsAntialiasing(context, YES);
    
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
   // CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    
    //画线笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
   
    //或CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    
    //线的宽度
    CGContextSetLineWidth(context, 2.0);

    
//1、画直线
    CGPoint aPoint[2];//坐标点
    aPoint[0] = CGPointMake(0, 0);
    aPoint[1] = CGPointMake(self.bounds.size.width,0);
    CGContextAddLines(context, aPoint,2);
    //CGContextStrokePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
// 画跟踪线
    //画线笔颜色
    //CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);//线框颜色
    CGPoint trakePoint[2];
    trakePoint[0] = CGPointMake(0, 0);
    trakePoint[1] = CGPointMake(CGRectGetWidth(self.bounds)*_progress, 0);
    CGContextAddLines(context, trakePoint, 2);
   // CGContextStrokePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
//2.发现画直线无法做到progressView两端圆角处理 用4条线圈起来一个progress
    
    CGFloat fW = self.bounds.size.width;
    
   /* CGContextAddArcToPoint(<#CGContextRef  _Nullable c#>, <#CGFloat x1#>, <#CGFloat y1#>, <#CGFloat x2#>, <#CGFloat y2#>, <#CGFloat radius#>)
    */
    CGContextMoveToPoint(context,5,50);
    CGContextAddArcToPoint(context, 0,55,5,60,6);
    CGContextAddArcToPoint(context, 5,60,fW-5,60,6); //
    CGContextAddArcToPoint(context, fW-5,60, fW,55,6); //
    CGContextAddArcToPoint(context, fW,55,fW-5,50,6); //
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFill); //根据坐标绘制路径
    
    CGFloat fW2 = self.bounds.size.width*_progress;
    CGContextMoveToPoint(context,5,50);
    CGContextAddArcToPoint(context, 0,55,5,60,6);
    CGContextAddArcToPoint(context, 5,60,fW2-5,60,6); //
    CGContextAddArcToPoint(context, fW2-5,60, fW,55,6); //
    CGContextAddArcToPoint(context, fW2,55,fW2-5,50,6); //
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextDrawPath(context, kCGPathEOFill); //根据坐标绘制路径
    
//3.用矩形做
    
    //CGContextSaveGState与CGContextRestoreGState的作用
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     */
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
    CGColorSpaceRelease(rgb);
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 120, 90);
    CGContextAddLineToPoint(context, 240, 90);
    CGContextAddLineToPoint(context, 240, 210);
    CGContextAddLineToPoint(context, 120, 210);
    CGContextClip(context);//context裁剪路径,后续操作的路径
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (120,90) ,CGPointMake(120,210),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context
    
    /*画矩形*/
    CGContextStrokeRect(context,CGRectMake(10, 120, 10, 10));//画方框
    
    CGContextFillRect(context,CGRectMake(10, 140, 50, 50));//填充框
    
    //矩形，并填弃颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    UIColor *aColor = [UIColor blueColor];//blue蓝色
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    
    //CGContextAddRect 与 CGContextFillRect区别是CGContextAddRect带边框
    CGContextAddRect(context,CGRectMake(140, 250, 60, 30));//画方框
    CGContextDrawPath(context, kCGPathFill);//绘画路径
    
 //画椭圆
   // CGContextAddEllipseInRect(<#CGContextRef  _Nullable c#>, <#CGRect rect#>)
    CGContextAddEllipseInRect(context, CGRectMake(20, 250,30, 30));
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
// 画三角形
    // 3个点 一条线 3个点连接起来
    CGPoint threePoint[3];
    threePoint[0]= CGPointMake(50, 260);
    threePoint[1]= CGPointMake(10, 300);
    threePoint[2]= CGPointMake(100, 300);
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}
-(CGFloat)progress
{
    return _progress;
}


-(void)setTrackTintColor:(UIColor *)AtrackTintColor
{
    _trackTintColor= AtrackTintColor;
    [self setNeedsDisplay];
}
-(UIColor *)trackTintColor
{
    return _trackTintColor;
}
-(void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    [self setNeedsDisplay];
    
}
-(UIColor *)progressTintColor
{
    return _progressTintColor;
}

@end
