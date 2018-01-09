//
//  XMGHomeHeaderView.h
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGHomeHeaderView : UIView

@property (nonatomic, strong) NSArray *ads;
@property (nonatomic, strong) NSArray *topTeachers;

@property(nonatomic,strong)void(^clickSetingBlock)();

@end
