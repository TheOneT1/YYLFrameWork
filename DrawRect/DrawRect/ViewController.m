//
//  ViewController.m
//  DrawRect
//
//  Created by yyl on 15/11/16.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "ViewController.h"
#import "ButtonAndLabel.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
{
    NSMutableArray *_arr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = [[NSMutableArray alloc] initWithArray:@[@"boli2.jpg",@"boli2.jpg",@"boli2.jpg",@"boli2.jpg",@"boli2.jpg",@"boli2.jpg"]];
    
    NSInteger hangshu = 0;
    hangshu = _arr.count/2;
    if (_arr.count%2>0) { hangshu+=1; }
    
    CGFloat bl_W = (KScreenWidth-40)/2;
    NSInteger count=0;
    for (int i=0; i<hangshu; i++) {
        for (int j=0; j<2; j++) {
            
            if (count>=_arr.count) break;
            ButtonAndLabel *bl = [[ButtonAndLabel alloc] initWithFrame:CGRectMake(10+(bl_W+20)*j,64+(bl_W+10)*i,bl_W, bl_W)];
            [self.view addSubview:bl];
            bl.imgeName = _arr[count];
            bl.tag = count;
            [bl addTarget:self withSeletor:@selector(blClick:)];
            bl.labText = [NSString stringWithFormat:@"%zd",count];
            count++;
        }
    }
    
   
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)blClick:(ButtonAndLabel *)bl
{
    NSLog(@"tag------%zd",bl.tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
