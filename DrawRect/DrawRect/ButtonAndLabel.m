//
//  ButtonAndLabel.m
//  DrawRect
//
//  Created by yyl on 15/11/16.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "ButtonAndLabel.h"

@implementation ButtonAndLabel
{
    UIImageView *_imgView;
    UILabel *_lab;
    
    id _tagert;
    SEL _sel;
}
@synthesize labText = _labText;
@synthesize imgeName = _imgeName;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc ]init];
        _imgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-20);
        _imgView.backgroundColor = [UIColor grayColor];
        [self addSubview:_imgView];
        
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(0,frame.size.height-20,frame.size.width, 20)];
        _lab.backgroundColor =[UIColor lightGrayColor];
        _lab.textAlignment =1;
        [self addSubview:_lab];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    _lab.text = _labText;
    _imgView.image = [UIImage imageNamed:_imgeName];
    
    
}
-(void)setLabText:(NSString *)labText
{
    _labText = labText;
    [self setNeedsDisplay];
}

-(void)setImgeName:(NSString *)imgeName
{
    _imgeName =imgeName;
    [self setNeedsDisplay];
}
-(void)addTarget:(id)target withSeletor:(SEL)sel
{
    _tagert = target;
    _sel = sel;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_tagert && _sel) {
        [_tagert performSelector:_sel withObject:self];
    }
}
@end
