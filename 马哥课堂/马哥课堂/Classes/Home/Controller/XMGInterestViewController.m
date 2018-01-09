//
//  XMGInterestViewController.m
//  马哥课堂
//
//  Created by liao on 18/1/5.
//  Copyright © 2018年 ndb. All rights reserved.
//

#import "XMGInterestViewController.h"
#import "XMGHttpManager.h"
#import "XMGNetworkManager.h"
#import "XMGInterestGroupItem.h"
#import <MJExtension.h>
#import "XMGInterestRowCell.h"
#import "XMGInterestRowItem.h"
#import "XMGGroupHeaderView.h"
#import "XMGTagListView.h"

#import "XMGInterestCell.h"
#import "XMGInterestItem.h"
#import "XMGInterestManager.h"
static NSString * const kinterID = @"interID";
static NSString * const selectInterID = @"selectInterID";
@interface XMGInterestViewController ()
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) XMGTagListView *tagListView;
@end

@implementation XMGInterestViewController
/** jiaz */
- (XMGTagListView *)tagListView
{
    if (_tagListView == nil) {
        _tagListView = [[XMGTagListView alloc] initWithFrame:CGRectMake(0, 0, XMGScreenW, 100)];
        __weak typeof (&*self)weakSelf = self;
        _tagListView.tagClickBlock = ^(NSString * tag){
            //点击标签调用
        [weakSelf clickTag:tag];
            
        };
        
    }
    return _tagListView;
}
- (NSMutableArray *)groups
{
    if (!_groups)
    {
        _groups  =[NSMutableArray array];
        //初始化第0组
        XMGInterestGroupItem * group =  [[XMGInterestGroupItem alloc] init];
        group.name = @"已选兴趣";
        [_groups addObject:group];
        
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self loadData];
    // 对应多少组
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGInterestRowCell" bundle:nil] forCellReuseIdentifier:kinterID];
    //注册普通cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:selectInterID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)loadData
{
    NSString *url = [XMGNetworkManager urlWithInteresting];
    NSDictionary *param = [XMGNetworkManager paramWithInteresting];
    
    [XMGHttpManager POST:url parameters:param progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
         [responseObject writeToFile:@"/Users/ndb/Desktop/interest.plist" atomically:YES];
        // 组模型数组
        NSArray *result = responseObject[@"result"];
        // 字典数组转模型数组
        [self.groups addObjectsFromArray: [XMGInterestGroupItem mj_objectArrayWithKeyValuesArray:result]];
        
        
        
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

     return _groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return 1;
    }
XMGInterestGroupItem *group = _groups[section];
    return group.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
    {
        UITableViewCell * oneCell = [tableView dequeueReusableCellWithIdentifier:selectInterID];
        //自定义标签view
        [oneCell addSubview:self.tagListView];
        return oneCell;
        
    }
    XMGInterestRowCell *cell = [tableView dequeueReusableCellWithIdentifier:kinterID forIndexPath:indexPath];
    
   
    cell.collectionView.delegate = self;

    
    XMGInterestGroupItem * group = _groups[indexPath.section];
    
    cell.rowItem = group.data[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return _tagListView.tagListViewH;
    }
    XMGInterestGroupItem * group = _groups[indexPath.section];
    XMGInterestRowItem *rowItem  =group.data[indexPath.row];
    NSLog(@"--%f",rowItem.cellH);
    return rowItem.cellH;
    
    
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XMGGroupHeaderView * headerView = [XMGGroupHeaderView groupHeaderView];
    headerView.group = _groups[section];
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(void)dealloc
{
    NSLog(@"----");
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //点击item,显示到第0组
    NSLog(@"----------");
    
    XMGInterestCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    XMGInterestItem * item  = cell.interest;
    //记录当前模型的选中状态
    item.isSelect =  !item.isSelect;
    cell.interest = item;
    
    if ( item.isSelect == YES)
    {
          [self.tagListView addTag:item.name];
    }
    else{
        //删除标签
        
        [self.tagListView deleteTag:item.name];
        
    }
  
    //刷新第0组
    NSIndexSet * IndexSet = [NSIndexSet indexSetWithIndex:0];
    
    [self.tableView reloadSections:IndexSet withRowAnimation:UITableViewRowAnimationNone];
    
}

/**
 监听标题的点击
 */
-(void)clickTag:(NSString * )tag
{
   //移除标签
    [self.tagListView deleteTag:tag];
    //取消兴趣选中
    //获取模型去修改
    //获取cell
    XMGInterestCell * cell  = [XMGInterestManager interestTagCellDict][tag];
    XMGInterestItem * item = cell.interest;
    item.isSelect = NO;
    
}
@end
