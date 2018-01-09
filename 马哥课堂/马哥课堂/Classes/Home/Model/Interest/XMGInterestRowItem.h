//
//  XMGInterestRowItem.h
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGInterestRowItem : NSObject
// 多少个小格子(兴趣)
// XMGInterestItem
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *name;

@property(nonatomic,assign)CGFloat cellH;

@end
