//
//  PromptTableViewCell.m
//
//  Created by xinstar on 16/5/26.
//  Copyright © 2016年 xinstar1. All rights reserved.
//

#import "PromptTableViewCell.h"

@implementation PromptTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.frame.size.width-self.leftEdge, self.frame.size.height)];
    self.emailLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.emailLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
