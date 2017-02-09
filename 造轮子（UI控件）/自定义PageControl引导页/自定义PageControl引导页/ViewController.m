//
//  ViewController.m
//  自定义PageControl引导页
//
//  Created by yyl on 15/11/11.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "ViewController.h"
#import "PageControl.h"
@interface ViewController ()<UIScrollViewDelegate,PageCotrolDelegate>
{
    UIScrollView    *_scrol;
    PageControl     *_pg;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrol = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_scrol];
    _scrol.delegate = self;
    _scrol.pagingEnabled = YES;
    _scrol.bounces = NO;
    _scrol.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*4, CGRectGetHeight(self.view.frame));
    for (int i=0; i<4; i++) {
        [_scrol addSubview:[self addSubViewImage:[NSString stringWithFormat:@"help%zd",i+1] rect:CGRectMake(CGRectGetWidth(self.view.frame)*i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))]];
      
    }
    
    [_scrol addSubview:[self addSubViewButton:@"helpBtn" rect:CGRectMake(CGRectGetWidth(self.view.frame)*3+105,CGRectGetHeight(self.view.frame)-50, 294/2,67/2)]];
    
    
    
    _pg = [[PageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-90,50, 180, 30)];
    [self.view addSubview:_pg];
    [self.view bringSubviewToFront:_pg];
    _pg.backgroundColor = [UIColor blueColor];
    _pg.delegate = self;
   // pg.dotCurrentPageColor = [UIColor redColor];
    _pg.numberOfPage = 4;
    _pg.currentPage = 0;
    
    

    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pg.currentPage = scrollView.contentOffset.x/(CGRectGetWidth(self.view.frame));
}
-(void)pageControlPageDidChange:(PageControl *)pageControl
{
    [UIView animateWithDuration:0.25 animations:^{
     _scrol.contentOffset = CGPointMake(pageControl.currentPage*CGRectGetWidth(self.view.frame), 0);
    }];
    
}
-(UIButton *)addSubViewButton:(NSString *)btnImgName rect:(CGRect)btnRect
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = btnRect;
    [btn setBackgroundImage:[UIImage imageNamed:btnImgName] forState:normal];
    [btn setTitle:@"立即体验" forState:normal];
    [btn setTitleColor:[UIColor redColor] forState:normal];
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(UIImageView*)addSubViewImage:(NSString *)imageName rect:(CGRect)imgRect
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgRect];
    imgView.image = [UIImage imageNamed:imageName];
    return imgView;
}

-(void)btnOnClick:(UIButton*)sender
{
    ViewController *weakSelf = self;
    [UIView animateWithDuration:2.f animations:^{
        _scrol.alpha = 0;
        _pg.alpha = 0;
        sender.alpha = 0;
        
    } completion:^(BOOL finished) {
        [_scrol removeFromSuperview];
        [_pg removeFromSuperview];
        [sender removeFromSuperview];
        
        UILabel *delailab =[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMidY(weakSelf.view.frame), CGRectGetWidth(self.view.frame), 100)];
        [weakSelf.view addSubview:delailab];
        delailab.text = @"欢迎来到德莱联盟！";
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
