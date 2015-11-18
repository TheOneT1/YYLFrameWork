//
//  ViewController.m
//  画ProgressView
//
//  Created by yyl on 15/11/12.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import "ViewController.h"
#import "YYLProgressView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YYLProgressView *progressView = [[YYLProgressView alloc] initWithFrame:CGRectMake(10, 50, 300, 600)];
    progressView.progress= 0.6;
    [self.view addSubview:progressView];
    self.view.backgroundColor  =[UIColor brownColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
