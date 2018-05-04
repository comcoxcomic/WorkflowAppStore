//
//  ViewController.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/3/17.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "ViewController.h"
#import "App.h"
#import "AppFrame.h"
#import "AppTableViewCell.h"
#import <MJRefresh.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
//用来存储应用数据
@property (nonatomic,strong) NSArray *apps;
@property (weak, nonatomic) IBOutlet UITableView *MainView;
- (IBAction)TabSelect:(id)sender;

@property (nonatomic, strong)MJRefreshNormalHeader *mjHeader;
@property (nonatomic, strong)MJRefreshAutoNormalFooter *mjFooter;
@end

@implementation ViewController

- (void)getRules {
    [Http requesetWithUrl:@"http://www.moxcomic.com:23333/Store/getApp" params:nil sucess:^(id responseObject) {
        App *app = [App yy_modelWithJSON:responseObject];
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < app.apps.count; i++) {
            AppFrame *appFrame = [[AppFrame alloc] init];
            appFrame.app = app.apps[i];
            [arr addObject:appFrame];
        }
        self.apps = arr;
        [self.MainView reloadData];
        
        
        //结束刷新状态
        [self.mjHeader endRefreshing];
        self.MainView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    } failure:^(id responseObject) {
        NSLog(@"%@",responseObject);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjRefreshData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mjHeader.automaticallyChangeAlpha = YES;
    // 隐藏时间
    self.mjHeader.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态,就是马上执行mjRefreshData方法
    [self.mjHeader beginRefreshing];
    self.MainView.mj_header = self.mjHeader;
    
    self.mjFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjLoadMoreData)];
    self.MainView.mj_footer = self.mjFooter;
}

#pragma mark - MJRefreshHeader
- (void)mjRefreshData {
    [self getRules];
}
#pragma mark - MJRefreshFooter
- (void)mjLoadMoreData {
    

//    mj_header和mj_footer每一种状态的文字可以自定义
//    [self.mjFooter setTitle:@"" forState:MJRefreshStateIdle];
//    [self.mjFooter setTitle:@"" forState:MJRefreshStatePulling];
//    [self.mjFooter setTitle:@"" forState:MJRefreshStateRefreshing];
//    [self.mjFooter setTitle:@"" forState:MJRefreshStateWillRefresh];
//    [self.mjFooter setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    
//    //分页还没到达最后一页时只要结束刷新状态即可
//    [self.mjFooter endRefreshing];
    //分页到达最后一页没有数据时 将footer置为"NoMoreData"
    [self.mjFooter setState:MJRefreshStateNoMoreData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //每个section都返回100行
    return self.apps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppFrame *appFrame = self.apps[indexPath.row];
    return appFrame.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //@"identifier"是一个标识 dequeueReusableCellWithIdentifier这个方法会重用单元格,单元格必须要重用不然单元格多了 内存消耗会特别大 用这种方式变的只是数据 单元格到一定数量之后就不会再创建了
    AppTableViewCell *cell = (AppTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"1111"];
    if (cell == nil) {
        cell = [[AppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1111"];
    }
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.appFrame = self.apps[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIEdgeInsets UIEgde = UIEdgeInsetsMake(0, 15, 0, 15);
    [cell setSeparatorInset:UIEgde];
    cell.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        cell.alpha = 1;
    }];
}

@end
