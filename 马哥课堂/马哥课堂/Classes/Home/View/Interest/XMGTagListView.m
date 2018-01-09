//
//  XMGTagListView.m
//  马哥课堂
//
//  Created by liao on 18/1/7.
//  Copyright © 2018年 ndb. All rights reserved.
//

#import "XMGTagListView.h"
@interface XMGTagListView ()

@property(nonatomic,strong)NSMutableDictionary* tagDict;
@end
@implementation XMGTagListView
- (NSMutableDictionary *)tagDict
{
    if (_tagDict == nil) {
        _tagDict = [NSMutableDictionary dictionary];
    }
    return _tagDict;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame] )
    {
        [self initial];
        
    }
    return self;
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
     [self initial];
}
-(void)initial
{
    _tagH = 30;
    
}
- (void)addTag:(NSString *)tag
{
    //创建一个按钮
    UIButton * tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle: tag forState:UIControlStateNormal];
    [tagButton setBackgroundColor:[UIColor greenColor]];
    [tagButton sizeToFit];

    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮尺寸
    [self setUpBUttonFram:tagButton i:self.subviews.count];
    [self addSubview:tagButton];
    
    //记录标签
    [self.tagDict setObject:tagButton forKey:tag];
    
    _tagListViewH = CGRectGetMaxY(tagButton.frame)+10;
    
    
}
- (void)setUpBUttonFram:(UIButton *)button i:(NSInteger)i
{
    CGFloat margin = 10;
    CGFloat btnx = margin;
    CGFloat btny = margin;
    
    CGFloat btnW =button.width+2*margin;
    CGFloat btnH = _tagH;
    //获取上一个按钮
    if (i == 0)
    {
        button.frame = CGRectMake(btnx, btny, btnW, btnH);
        
    }
    else
    {
        //获取上一个按钮
        UIButton * preButton = self.subviews[i-1];
        btnx = CGRectGetMaxX(preButton.frame) +margin;
        btny  = preButton.y;
        CGFloat maxW = btnx+button.width +margin;
        if (maxW> self.width)
        {
            btnx = margin;
            btny = CGRectGetMaxY(preButton.frame) +margin;
           
        }
        
            button.frame = CGRectMake(btnx, btny, btnW, btnH);
        
        
        
    }
}

- (void)deleteTag:(NSString *)tag
{
    //移除标签按钮
    UIButton * button = self.tagDict[tag];
    //获取当前按钮的角标
    NSInteger currentI  = [self.subviews indexOfObject:button];
  
    
    //移除
    [button removeFromSuperview];
    //移除字典
    [self.tagDict removeObjectForKey:tag];
    if (currentI < self.subviews.count)
    {
        //计算其他按钮的位置
        for (NSInteger i =  currentI; i <self.subviews.count; i++)
        {
            UIButton * btn = self.subviews[i];
            [self setUpBUttonFram:btn i:i];
            
        }
    }
    //标签高度
    UIButton * lastButton = self.subviews.lastObject;
    
    _tagListViewH = lastButton == nil ?0:  CGRectGetMaxY(lastButton.frame)+10;
}
-(void)tagButtonClick:(UIButton *)button
{
    
    if (_tagClickBlock)
    {
        _tagClickBlock(button.currentTitle);
        
    }
}
@end
