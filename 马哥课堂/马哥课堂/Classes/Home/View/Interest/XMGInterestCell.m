//
//  XMGInterestCell.m
//  马哥课堂
//
//  Created by liao on 18/1/5.
//  Copyright © 2018年 ndb. All rights reserved.
//

#import "XMGInterestCell.h"
#import "XMGInterestItem.h"
@interface XMGInterestCell ()
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end
@implementation XMGInterestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor greenColor].CGColor;
   
}
- (void)setInterest:(XMGInterestItem *)interest
{
    _interest = interest;
    _labelView.text = interest.name;
    _labelView.textColor = interest.isSelect ? [UIColor greenColor] : [UIColor blackColor];
    
}

@end
