//
//  XMGTagListView.h
//  马哥课堂
//
//  Created by liao on 18/1/7.
//  Copyright © 2018年 ndb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTagListView : UIView

@property(nonatomic,assign)CGFloat  tagH;
@property(nonatomic,assign)CGFloat  tagListViewH;

/**
 标签点击block
 */
@property(nonatomic,strong)void(^tagClickBlock)(NSString * tag);
- (void)addTag:(NSString *)tag;

- (void)deleteTag:(NSString *)tag;
@end
