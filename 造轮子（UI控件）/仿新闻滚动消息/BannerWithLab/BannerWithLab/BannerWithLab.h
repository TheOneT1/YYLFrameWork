//
//  BannerWithLab.h
//  BannerWithLab
//
//  Created by yyl on 15/11/17.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LabClikced) (NSDictionary *dic);
@interface BannerWithLab : UIScrollView<UIScrollViewDelegate>

{
    // 上下提示lab
    UILabel *_topLab; // 上
    UILabel *_midLab; // 中
    UILabel *_botmLab; // 下
    
    LabClikced _labClick;
    
}
@property(nonatomic,retain)NSArray *labTextArray;

-(void)labfinishedClick:(LabClikced)click;
@end
