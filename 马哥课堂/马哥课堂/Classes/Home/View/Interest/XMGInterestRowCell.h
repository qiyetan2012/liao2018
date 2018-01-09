//
//  XMGInterestRowCell.h
//  马哥课堂
//
//  Created by liao on 18/1/5.
//  Copyright © 2018年 ndb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGInterestRowItem;
@interface XMGInterestRowCell : UITableViewCell
@property (weak, nonatomic,readonly) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong)XMGInterestRowItem * rowItem;
@end
