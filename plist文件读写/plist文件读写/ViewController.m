//
//  ViewController.m
//  plist文件读写
//
//  Created by yyl on 15/11/9.
//  Copyright (c) 2015年 fssj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
/***********************************
 1,plist文件无序
 2,plist文件可以存放 NSArray, NSDictionary, BOOL, NSData, NSDate, NSNumber, NSString
 
 ***********************************/


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取路径 已经存在的plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSLog(@"第一次输出pist数据------%@",data);
    
    // 代码创建plist文件
    // 沙盒路径
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoty  = [paths objectAtIndex:0];
    NSLog(@"输出文档沙盒路径-----%@",documentsDirectoty);
    
    

    
    // 创建plist路径
    NSString *pilstPath = [documentsDirectoty stringByAppendingPathComponent:@"Test2.plist"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    //读操作之前更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectoty stringByExpandingTildeInPath]];
    
    //判断该plist是否存在
    if (![fileManager fileExistsAtPath:pilstPath]) {
        // 创建文件
        
        BOOL result = [fileManager createFileAtPath:pilstPath contents:nil attributes:nil];
        if (result) {
            NSLog(@"Test2.plist创建成功");
            
            //写文件
            NSDictionary *dataDic = @{@"name":@"黎明",@"sex":@"man"};
            [dataDic writeToFile:pilstPath atomically:YES];
            
            //读文件（plist文件存储是无序的）
            NSMutableDictionary *getdata=[[NSMutableDictionary alloc] initWithContentsOfFile:pilstPath];
             NSLog(@"输出Test2.pist数据------%@",getdata);
            
            // 删除数据 增加数据 修改数据类似
            // 删除数据只需要删除字典里面对应的key 再次把数据写入即可，
            
            
        // 删除plist文件
           // [fileManager removeItemAtPath:pilstPath error:nil];
            
        }else{
            NSLog(@"Test2文件创建失败");
        }
        
    
        
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
