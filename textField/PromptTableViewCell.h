//
//  PromptTableViewCell.h
//  Memory
//
//  Created by developer-ai on 16/5/23.
//  Copyright © 2016年 blueliveMBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptTableViewCell : UITableViewCell

@property (assign, nonatomic) CGFloat leftEdge;

@property (strong, nonatomic) NSString *emailText;

@property (strong, nonatomic) UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UIButton *tapButton;

@end
