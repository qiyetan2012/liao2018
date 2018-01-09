//
//  XMGInterestRowItem.m
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGInterestRowItem.h"
@implementation XMGInterestRowItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":@"XMGInterestItem"};
    
}

-(void)setData:(NSArray *)data
{
    _data = data;
    CGFloat originY = 27;
    CGFloat margin = 10;
    NSInteger cols = 4;
    NSInteger rows = (_data.count - 1)/cols+1;
    CGFloat collectionH = rows* 30+(rows-1)*margin;
    _cellH = originY+ collectionH + margin;
}
//-(CGFloat)cellH
//{
//    
//   
//    return _cellH;
//    
//    
//    
//    
//}
@end
