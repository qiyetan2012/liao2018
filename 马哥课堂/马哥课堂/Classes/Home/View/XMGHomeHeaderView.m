//
//  XMGHomeHeaderView.m
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGHomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "XMGHomeADItem.h"
#import "XMGHomeTeacherCell.h"
static NSString * const topTeacherID = @"topTeacherID";
@interface XMGHomeHeaderView ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UICollectionView *ZXcollectionVieew;

@end
@implementation XMGHomeHeaderView

-(void)awakeFromNib

{
    [super awakeFromNib];
    //初始化布局
    UICollectionViewFlowLayout * layout = _ZXcollectionVieew.collectionViewLayout;
    //水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 3;;
    layout.itemSize = CGSizeMake(width, 120);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
     //注册
    [_ZXcollectionVieew registerNib:[UINib nibWithNibName:@"XMGHomeTeacherCell" bundle:nil] forCellWithReuseIdentifier:topTeacherID];
    
    _ZXcollectionVieew.dataSource = self;
    _ZXcollectionVieew.pagingEnabled = YES;
    _ZXcollectionVieew.showsHorizontalScrollIndicator = NO;
    
}

-(void)setAds:(NSArray *)ads
{
    _ads = ads;
    
    NSMutableArray * urls = [NSMutableArray array];
    for (XMGHomeADItem  * item in ads)
    {
        [urls addObject:item.url];
        
    }
    _bannerView.placeholderImage = [UIImage imageNamed:@""];
    
    _bannerView.imageURLStringsGroup = urls;
    
}
-(void)setTopTeachers:(NSArray *)topTeachers
{
    _topTeachers = topTeachers;
        [_ZXcollectionVieew reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _topTeachers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 尽量使用forIndexPath
    XMGHomeTeacherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topTeacherID forIndexPath:indexPath];
    
    cell.teacher = _topTeachers[indexPath.row];
    
    return cell;
}

- (IBAction)clickSeting:(id)sender
{
    if (_clickSetingBlock)
    {
        _clickSetingBlock();
    }
}
@end
