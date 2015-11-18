//
//  ViewController.m
//  ExpendTableView
//
//  Created by yyl on 15/11/16.
//  Copyright (c) 2015年 fssj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _numsOfRow;
}
@property(nonatomic,retain)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numsOfRow=2;
    
    [self initTableView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame= CGRectMake(100, 20, 100, 30);
    [btn setTitle:@"expend" forState:normal];
    [btn setTitleColor:[UIColor brownColor] forState:normal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initTableView
{
    
    //create table
    _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44*2) style:UITableViewStyleGrouped];
    _tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boli3"]];
    _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
}
-(void)addBtnClick
{
    _numsOfRow = 10;
    NSMutableArray *mulArr = [[NSMutableArray alloc] init];
    _tableView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44*_numsOfRow);
    for (int i=0; i<_numsOfRow-2; i++) {
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [mulArr addObject:indexPath];
    }
    [_tableView insertRowsAtIndexPaths:mulArr withRowAnimation:UITableViewRowAnimationTop];
    
}
#pragma mark-
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _numsOfRow;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];

    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text=  @"25";
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
