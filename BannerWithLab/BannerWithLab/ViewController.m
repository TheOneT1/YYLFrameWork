//
//  ViewController.m
//  BannerWithLab
//
//  Created by yyl on 15/11/17.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "ViewController.h"
#import "BannerWithLab.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 50, 30)];
    [btn setImage:[UIImage imageNamed:@"discover_tongzhi_default"] forState:normal];
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    
    BannerWithLab *bl =[[BannerWithLab alloc] initWithFrame:CGRectMake(50, 100,CGRectGetWidth(self.view.frame), 30)];
    [self.view addSubview:bl];
    bl.backgroundColor =[UIColor lightGrayColor];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        [arr addObject:[NSString stringWithFormat:@"第%d条数据~~~",i]];
    }
    
    bl.labTextArray = arr;
    [bl labfinishedClick:^(NSDictionary *dic) {
        NSLog(@"dic====%@",dic);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
