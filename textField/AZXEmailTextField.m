//
//  AZXEmailTextField.m
//
//  Created by xinstar1 on 16/5/26.
//  Copyright © 2016年 xinstar1. All rights reserved.
//

#import "AZXEmailTextField.h"
#import "PromptTableViewCell.h"

#define pCellH self.frame.size.height

@interface AZXEmailTextField ()<UITableViewDataSource, UITableViewDelegate>

// 邮箱下拉提示列表
@property (strong, nonatomic) UITableView *promptTableView;

// 邮箱后缀数组
@property (strong, nonatomic) NSArray *emailSuffixArray;

// 匹配输入的邮箱后缀数组(用来显示在列表中)dataSource
@property (strong, nonatomic) NSArray *matchedSuffixArray;

// 下拉提示的字符离左边的距离
@property (assign, nonatomic) CGFloat pLeftMargin;

// 字体大小
@property (strong, nonatomic) UIFont *textFont;

// 字体颜色
@property (strong, nonatomic) UIColor *color;

// cell的背景色
@property (strong, nonatomic) UIColor *cellColor;

// cell的高度
@property (assign, nonatomic) CGFloat pCellHeight;

// 分割线缩进
@property (strong, nonatomic) NSArray *pInsetArray;

@end

@implementation AZXEmailTextField

- (instancetype)initWithFrame:(CGRect)frame InView:(UIView *)view {
    if (self = [super initWithFrame:frame]) {
        return [self setUpInView:view];
    }
    return nil;
}

- (instancetype)setUpInView:(UIView *)view {
    CGFloat textX = self.frame.origin.x;
    CGFloat textY = self.frame.origin.y;
    CGFloat textH = self.frame.size.height;
    CGFloat textW = self.frame.size.width;
    
    self.promptTableView = [[UITableView alloc] initWithFrame:CGRectMake(textX, textY+textH+1, textW, pCellH*3) style:UITableViewStylePlain];
    
    self.promptTableView.dataSource = self;
    self.promptTableView.delegate = self;
    
    [self setUpEmailSuffixArray];
    
    [self.promptTableView registerNib:[UINib nibWithNibName:@"PromptTableViewCell" bundle:nil]    forCellReuseIdentifier:@"promptCell"];
    self.promptTableView.userInteractionEnabled = YES;
    self.promptTableView.hidden = YES;
    [view addSubview:self.promptTableView];
    
    [self addTarget:self action:@selector(textFieldDidChanged) forControlEvents:UIControlEventEditingChanged];
    
    self.keyboardType = UIKeyboardTypeASCIICapable;
    
    return self;
}

- (void)textFieldDidChanged {
    if ([self.text containsString:@"@"]) {
        self.promptTableView.hidden = NO;
        // @后面的subString
        NSString *latterStr = [self.text substringFromIndex:[self.text rangeOfString:@"@"].location+1];
        if ([latterStr isEqualToString:@""]) {
            self.matchedSuffixArray = self.emailSuffixArray;
        } else {
            self.matchedSuffixArray = [self.emailSuffixArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self beginswith %@", [self deleteSpacesInString:latterStr]]];
            if (self.matchedSuffixArray.count == 0) {
                self.promptTableView.hidden = YES;
            }
        }
        
        [self.promptTableView reloadData];
    } else {
        self.promptTableView.hidden = YES;
    }
}

// 去掉空格
- (NSString *)deleteSpacesInString:(NSString *)string {
    if ([string containsString:@" "]) {
        return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    } else {
        return string;
    }
}

- (void)setUpEmailSuffixArray {
    self.emailSuffixArray = @[
                              @"qq.com",
                              @"163.com",
                              @"126.com",
                              @"sina.com",
                              @"gmail.com",
                              @"vip.sina.com",
                              @"outlook.com",
                              @"foxmail.com",
                              @"hotmail.com",
                              @"tom.com",
                              @"yahoo.com",
                              @"icloud.com",
                              @"sohu.com",
                              @"live.com",
                              @"msn.com",
                              @"138.com",
                              @"188.com",
                              @"21cn.com",
                              @"263.net"
                              ];
}


#pragma mark - public API

- (void)setTableViewFrame:(CGRect)frame {
    self.promptTableView.frame = frame;
}

- (void)setLeftMargin:(CGFloat)margin {
    self.pLeftMargin = margin;
    [self.promptTableView reloadData];
}

- (void)hideEmailPrompt {
    self.promptTableView.hidden = YES;
}

- (void)setTableViewSuffixArray:(NSArray *)suffixArray {
    self.emailSuffixArray = suffixArray;
    [self.promptTableView reloadData];
}

- (CGRect)tableViewFrame {
    return self.promptTableView.frame;
}

- (void)setCellHeight:(CGFloat)height {
    self.pCellHeight = height;
    [self.promptTableView reloadData];
}

- (void)setTableViewFont:(UIFont *)font {
    self.textFont = font;
    [self.promptTableView reloadData];
}

- (void)setTableViewTextColor:(UIColor *)color {
    self.color = color;
    [self.promptTableView reloadData];
}

- (void)setTableViewBackgroundColor:(UIColor *)color {
    self.promptTableView.backgroundColor = color;
}

- (void)setCellBackgroundColor:(UIColor *)color {
    self.cellColor = color;
    [self.promptTableView reloadData];
}

- (void)setSeparatorInsets:(NSArray *)insetArray {
    self.pInsetArray = insetArray;
    [self.promptTableView reloadData];
}

#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.matchedSuffixArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromptTableViewCell *cell = [self.promptTableView dequeueReusableCellWithIdentifier:@"promptCell" forIndexPath:indexPath];
    // @之前的字符串
    NSString *formerStr = [self.text substringToIndex:[self.text rangeOfString:@"@"].location+1];
    cell.emailLabel.text = [formerStr stringByAppendingString:self.matchedSuffixArray[indexPath.row]]        ;
    CGRect rect = cell.emailLabel.frame;
    
    // 如果没有自定义则按默认样式
    if (self.textFont) cell.emailLabel.font = self.textFont;
    if (self.color) cell.emailLabel.textColor = self.color;
    if (self.cellColor) cell.backgroundColor = self.cellColor;
    if (self.pCellHeight) {
        rect.size.height = self.pCellHeight;
        cell.emailLabel.frame = rect;
    } else {
        rect.size.height = pCellH;
        cell.emailLabel.frame = rect;
    }
    
    
    rect.origin.x = self.pLeftMargin;
    cell.emailLabel.frame = rect;
    cell.tapButton.tag = indexPath.row;
    [cell.tapButton addTarget:self action:@selector(tapCell:) forControlEvents:UIControlEventTouchUpInside];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 && self.pInsetArray) {
        cell.separatorInset = UIEdgeInsetsMake([self.pInsetArray[0] floatValue], [self.pInsetArray[1] floatValue], [self.pInsetArray[2] floatValue], [self.pInsetArray[3] floatValue]);
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.pCellHeight ? self.pCellHeight : pCellH;
}

- (void)tapCell:(UIButton *)sender {
    NSString *formerStr = [self.text substringToIndex:[self.text rangeOfString:@"@"].location+1];
    self.text = [formerStr stringByAppendingString:self.matchedSuffixArray[sender.tag]];
    self.promptTableView.hidden = YES;
}


@end
