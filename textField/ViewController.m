//
//  ViewController.m
//  textField
//
//  Created by xinstar1 on 16/5/27.
//  Copyright © 2016年 developer-ai. All rights reserved.
//

// 这个demo展示了用Xib/Storyboard布局时的使用方法，如果是纯代码布局直接用初始化方法就好

#import "ViewController.h"
#import "AZXEmailTextField.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *placeHolderView; // 只是用来定位要加入textField的位置

@property (assign, nonatomic) BOOL hasExecuted;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.hasExecuted) { // 只执行一次，防止重复加入textField
        [self setUpUI];
        self.hasExecuted = YES;
    }
}

- (void)setUpUI {
    // 先将用来定位的textField隐藏起来
    self.placeHolderView.hidden = YES;
    AZXEmailTextField *textField = [[AZXEmailTextField alloc] initWithFrame:self.placeHolderView.frame InView:self.view];
    textField.placeholder = @"输入用户邮箱";
    textField.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:textField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
