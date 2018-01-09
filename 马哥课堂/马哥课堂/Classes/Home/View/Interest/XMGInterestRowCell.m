//
//  XMGInterestRowCell.m
//  马哥课堂
//
//  Created by liao on 18/1/5.
//  Copyright © 2018年 ndb. All rights reserved.
//

#import "XMGInterestRowCell.h"
#import "XMGInterestRowItem.h"
#import "XMGInterestCell.h"
#import "XMGInterestManager.h"
#import "XMGInterestItem.h"
static NSString * const interCell = @"interCell";
@interface XMGInterestRowCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end
@implementation XMGInterestRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    //设置collectionview不能滚动
    _collectionView.scrollEnabled = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"XMGInterestCell" bundle:nil] forCellWithReuseIdentifier:interCell];
    
    
    // 获取布局
    UICollectionViewFlowLayout *layout = _collectionView.collectionViewLayout;
    CGFloat margin = 10;
    NSInteger cols = 4;
    //item宽度
    CGFloat width = (XMGScreenW - (cols + 1) * margin) / cols;
    CGFloat height = 30;
    
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
}

-(void)setRowItem:(XMGInterestRowItem *)rowItem
{
    _rowItem = rowItem;
    
    _labelView.text = rowItem.name;
    
    [_collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _rowItem.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGInterestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:interCell forIndexPath:indexPath];
    
    cell.interest = _rowItem.data[indexPath.row];
    
    //绑定字典
    [XMGInterestManager interestTagCellDict][cell.interest.name] = cell;
    
    return cell;
}


@end
