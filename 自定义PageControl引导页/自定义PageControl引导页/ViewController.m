//
//  ViewController.m
//  自定义PageControl引导页
//
//  Created by yyl on 15/11/11.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "ViewController.h"
#import "PageControl.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PageControl *pg = [[PageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-60, 120, 120, 30)];
    [self.view addSubview:pg];
   // pg.dotCurrentPageColor = [UIColor redColor];
    pg.numberOfPage = 5;
    pg.currentPage = 1;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
