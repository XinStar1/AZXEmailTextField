//
//  AZXEmailTextField.h
//  Memory
//
//  Created by developer-ai on 16/5/26.
//  Copyright © 2016年 blueliveMBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZXEmailTextField : UITextField

/// 自定义下拉提示的字符离左边的距离
- (void)setLeftMargin:(CGFloat)margin;

/// 自定义邮箱下拉列表在初始化所设的超类superview中的frame
- (void)setTableViewFrame:(CGRect)frame;

/// 隐藏下拉提示
- (void)hideEmailPrompt;

/// 初始化并返回一个新的AZXEmailTextField，自定义其Frame以及superview
- (instancetype)initWithFrame:(CGRect)frame InView:(UIView *)view;

/// 当前下拉列表的frame，自定义其frame时可通过此属性先取得默认frame，再进行修改
@property (assign, nonatomic) CGRect tableViewFrame;

/// 设置下拉列表行高
- (void)setCellHeight:(CGFloat)height;

/// 设置下拉列表所有cell的背景颜色
- (void)setCellBackgroundColor:(UIColor *)color;

/// 设置下拉列表的背景颜色
- (void)setTableViewBackgroundColor:(UIColor *)color;

/// 设置下拉列表的字体
- (void)setTableViewFont:(UIFont *)font;

/// 设置下拉列表的字体颜色
- (void)setTableViewTextColor:(UIColor *)color;

@end
