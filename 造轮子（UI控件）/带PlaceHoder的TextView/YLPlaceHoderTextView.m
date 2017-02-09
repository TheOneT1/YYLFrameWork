//
//  YLPlaceHoderTextView.m
//  LRTextView
//
//  Created by fs_work on 2017/2/7.
//  Copyright © 2017年 scorpio. All rights reserved.
//

#import "YLPlaceHoderTextView.h"
static CGFloat const YLPlaceHoderLabelX = 6.0; // x轴起始位置
static CGFloat const YLPlaceHoderLabelY = 7.0; // y轴其实位置
#define YLPlaceHoderLabelWidth  self.frame.size.width - 2 * YLPlaceHoderLabelX

@interface YLPlaceHoderTextView()

/* 占位文字label */
@property (nonatomic,strong) UILabel *placeHoderLabel;

@end

@implementation YLPlaceHoderTextView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        //默认字体大小
        self.font = [UIFont systemFontOfSize:17];
        
        //默认占位文字颜色
        self.placehoderColor = [UIColor grayColor];
        
        //监听文字
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}

-(UILabel *)placeHoderLabel
{
    if (_placeHoderLabel == nil) {
        
        _placeHoderLabel = [[UILabel alloc] init];
        _placeHoderLabel.numberOfLines = 0;
        _placeHoderLabel.text = @"请输入内容...";
        [self addSubview:_placeHoderLabel];
    }
    
    return _placeHoderLabel;
}

- (void)textDidChangeNotification
{
    self.placeHoderLabel.hidden = self.hasText;
}

// 目的更新placeholder的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更新placehoderLabel的frame
    self.placeHoderLabel.frame = CGRectMake(YLPlaceHoderLabelX, YLPlaceHoderLabelY,YLPlaceHoderLabelWidth, 0);
    [self.placeHoderLabel sizeToFit];
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = placehoder;
    
    self.placeHoderLabel.text = placehoder;
    
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    self.placeHoderLabel.textColor = placehoderColor;
}

// 重写set
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChangeNotification];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChangeNotification];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
