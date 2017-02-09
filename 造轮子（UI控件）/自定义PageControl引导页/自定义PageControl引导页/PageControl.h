//
//  PageControl.h
//  自定义PageControl引导页
//
//  Created by yyl on 15/11/11.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PageCotrolDelegate;

@interface PageControl : UIView
{
    NSInteger _currentPage;
    NSInteger _numberOfPage;
    NSObject<PageCotrolDelegate>*delegate;
}

/*
 currentPage:当前页
 numberOfPage:总页数
 */
@property(nonatomic,assign) NSInteger currentPage;
@property(nonatomic,assign) NSInteger numberOfPage;


@property(nonatomic,retain)UIColor *dotCurrentPageColor;//当前圆点颜色
@property(nonatomic,retain)UIColor *dotOtherPageColor;//其他颜色
@property(nonatomic,strong)NSObject<PageCotrolDelegate> *delegate;
@end

@protocol PageCotrolDelegate <NSObject>
@optional
-(void)pageControlPageDidChange:(PageControl*)pageControl;

@end
