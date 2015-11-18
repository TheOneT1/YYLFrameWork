//
//  YYLProgressView.h
//  画ProgressView
//
//  Created by yyl on 15/11/12.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface YYLProgressView : UIView
{
    CGFloat _progress;
    UIColor *_trackTintColor;
    UIColor *_progressTintColor;
}

/*
 trackTintColor: 已完成进度色
 progressTintColor : 填充色
 progress:进度
 
 */
@property(nonatomic,retain)UIColor* trackTintColor;
@property(nonatomic,retain)UIColor* progressTintColor;
@property(nonatomic,assign)CGFloat progress;
@end
