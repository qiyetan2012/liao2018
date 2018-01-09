//
//  XMGInterestGroupItem.m
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGInterestGroupItem.h"

@implementation XMGInterestGroupItem
// MJExtension:是不会把数组中字典直接转模型

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":@"XMGInterestRowItem"};
}

@end
