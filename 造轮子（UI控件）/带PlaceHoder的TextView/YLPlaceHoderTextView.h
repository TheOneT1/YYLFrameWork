//
//  YLPlaceHoderTextView.h
//  LRTextView
//
//  Created by fs_work on 2017/2/7.
//  Copyright © 2017年 scorpio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPlaceHoderTextView : UITextView

/** 占位文字 */
@property(nonatomic,copy) NSString* placehoder;

/** 占位颜色 */
@property(nonatomic,strong) UIColor* placehoderColor;

@end
