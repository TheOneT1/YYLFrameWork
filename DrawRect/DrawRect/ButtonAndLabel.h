//
//  ButtonAndLabel.h
//  DrawRect
//
//  Created by yyl on 15/11/16.
//  Copyright © 2015年 fssj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonAndLabel : UIView

@property(nonatomic,retain)NSString *imgeName;
@property(nonatomic,retain)NSString *labText;

-(void)addTarget:(id)target withSeletor:(SEL)sel;
@end
