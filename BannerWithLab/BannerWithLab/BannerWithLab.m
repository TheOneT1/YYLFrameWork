//
//  BannerWithLab.m
//  BannerWithLab
//
//  Created by yyl on 15/11/17.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "BannerWithLab.h"
#define KScrollWidth self.bounds.size.width
#define KScrollHeight self.bounds.size.height
#define BannerTag 1000000

@implementation BannerWithLab
{
    
    NSTimer *_moveTimer;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    NSUInteger currentLab ;//记录中间图片的下标,开始总是为1
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.scrollEnabled = NO;
        self.contentSize = CGSizeMake(KScrollWidth, KScrollHeight*3);
        self.contentOffset = CGPointMake(0, KScrollHeight);//默认展示midlab
        currentLab = 0;
        self.delegate = self;
        
        
        _topLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScrollWidth,KScrollHeight)];
        [self addSubview:_topLab];
        //_topLab.backgroundColor = [UIColor redColor];
        
        _midLab=[[UILabel alloc] initWithFrame:CGRectMake(0, KScrollHeight, KScrollWidth,KScrollHeight)];
        //_midLab.backgroundColor = [UIColor greenColor];
        [self addSubview:_midLab];
        
        
        _botmLab = [[UILabel alloc] initWithFrame:CGRectMake(0,KScrollHeight*2, KScrollWidth, KScrollHeight)];
       // _botmLab.backgroundColor = [UIColor blueColor];
        [self addSubview:_botmLab];
        
        _moveTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labTap)];
         UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labTap)];
         UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labTap)];
        _midLab.userInteractionEnabled = YES;
        _topLab.userInteractionEnabled = YES;
        _botmLab.userInteractionEnabled = YES;
        [_midLab addGestureRecognizer:tap];
        [_topLab addGestureRecognizer:tap2];
        [_botmLab addGestureRecognizer:tap3];
    }
    return self;
}
-(void)onTimer
{
    [self setContentOffset:CGPointMake(0, KScrollHeight*2) animated:YES];
   // NSLog(@"current==%zd  输出y的位置------%f",currentLab,self.contentOffset.y);
    
    _isTimeUp =YES;
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];

    
}
#pragma mark - 图片停止时,调用该函数使得滚动视图复用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (self.contentOffset.y==0) {
        currentLab = (currentLab-1)%_labTextArray.count;
    }else if(self.contentOffset.y==KScrollHeight*2){
        currentLab = (currentLab+1)%_labTextArray.count;//***关键逻辑 这里currentLab累加
    }else{
        return;
    }
    
    if (_labTextArray.count>=2) {
        _midLab.text = _labTextArray[currentLab%_labTextArray.count];
        _topLab.text = _labTextArray[(currentLab-1)%_labTextArray.count];
        _botmLab.text= _labTextArray[(currentLab+1)%_labTextArray.count];
        
        _midLab.tag = BannerTag + currentLab%_labTextArray.count;
        _topLab.tag = BannerTag + (currentLab-1)%_labTextArray.count;
        _botmLab.tag= BannerTag + (currentLab+1)%_labTextArray.count;
    }else if(_labTextArray.count==1){
        
        _midLab.text = _labTextArray[currentLab%_labTextArray.count];
        _midLab.tag = BannerTag + currentLab%_labTextArray.count;
    }
   
    //更新完毕后，偷偷把ScrollView拉回到中间的ImageView位置，这样视觉效果上就实现了无限循环的效果
    [self setContentOffset:CGPointMake(0, KScrollHeight) animated:NO];
    
}
-(void)setLabTextArray:(NSArray *)labTextArray
{
    _labTextArray = labTextArray;
    if (_labTextArray.count>=2) {
        _topLab.text = labTextArray[labTextArray.count-1];
        _midLab.text =labTextArray[0];
        _botmLab.text =labTextArray[1];
    }else if(_labTextArray.count==1)
    {
        _midLab.text = labTextArray[0];
        [_moveTimer invalidate];
        [self setScrollEnabled:NO];
        
    }
    
    _topLab.tag = BannerTag +_labTextArray.count-1;
    _midLab.tag = BannerTag + 0;
    _botmLab.tag= BannerTag + 1;
    
}
-(void)labTap
{
    NSLog(@"输出当前第几张---%zd",currentLab);
    _labClick(@{@"key":[NSString stringWithFormat:@"%zd",currentLab]});
}
-(void)labfinishedClick:(LabClikced)click
{
    _labClick = click;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
