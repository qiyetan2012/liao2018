//
//  XMGHomeViewController.m
//  码哥课堂
//
//  Created by yz on 2016/12/9.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGHomeViewController.h"
#import "XMGNetworkManager.h"

#import "XMGHttpManager.h"
#import <MJExtension.h>
#import "XMGHomeADItem.h"
#import "XMGHomeRecommendItem.h"
#import "XMGHomeTopTeacherItem.h"
#import "XMGHomeHeaderView.h"
#import <SDCycleScrollView.h>
#import "XMGHomeRecommendCell.h"
#import "XMGInterestViewController.h"
static NSString * const homeId = @"HOME";
@interface XMGHomeViewController ()
@property (nonatomic, strong) NSArray *recommends;
@property (nonatomic, strong) NSArray *topTeachers;
@property (nonatomic, strong) NSArray *ads;

@property(nonatomic,strong)XMGHomeHeaderView * herderView;
@end

@implementation XMGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    //添加头部视图
    [self setUpHeaderView];
    self.tableView.dataSource  =self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGHomeRecommendCell" bundle:nil] forCellReuseIdentifier:homeId];
}
-(void)setUpHeaderView
{
    XMGHomeHeaderView * headerView = [XMGHomeHeaderView viewFromXib];
    headerView.clickSetingBlock= ^{
        
        XMGInterestViewController *interestVc = [[XMGInterestViewController alloc] init];
        
        // 点击设置
        [self.navigationController pushViewController:interestVc animated:YES];
    };
    
    self.tableView.tableHeaderView = headerView;
 
    _herderView = headerView;
   
   }
#pragma mark --- 数据加载
-(void)loadData
{
    // URL
    NSString *url = [XMGNetworkManager urlWithHome];
    
    // 参数
    NSDictionary *param = [XMGNetworkManager paramWithHome];
    
    [XMGHttpManager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSNULL
        [responseObject writeToFile:@"/Users/ndb/Desktop/OneToOne 2017-12-27 17-35-12.plist" atomically:YES];

        NSLog(@"%@",responseObject);
        
        NSDictionary *result = responseObject[@"result"];
        
        // 获取广告数据
        _ads = [XMGHomeADItem mj_objectArrayWithKeyValuesArray:result[@"ad"]];
        
        // 获取推荐课程（栅栏广告）
        NSDictionary *recommendsDict = result[@"recommends"];
        _recommends =  [XMGHomeRecommendItem mj_objectArrayWithKeyValuesArray: recommendsDict[@"courses"]];
        
        // 获取热门老师
        NSDictionary *topTeacherDict = result[@"topTeacher"];
        _topTeachers = [XMGHomeTopTeacherItem mj_objectArrayWithKeyValuesArray:topTeacherDict[@"courses"]];
        _herderView.ads = _ads;
        
        _herderView.topTeachers = _topTeachers;
         [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:homeId forIndexPath:indexPath];
    
    cell.recommend = _recommends[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
