//
//  XMGInterestManager.m
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGInterestManager.h"

static NSMutableDictionary *_interestTagCellDict;

@implementation XMGInterestManager
+ (NSMutableDictionary *)interestTagCellDict
{
    if (_interestTagCellDict == nil ) {
        
        _interestTagCellDict = [NSMutableDictionary dictionary];
    }
    return _interestTagCellDict;
}

@end
