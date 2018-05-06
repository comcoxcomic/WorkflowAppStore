//
//  CanKuCollectionViewController.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/5/7.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "CangKuCollectionViewController.h"
#import <MJRefresh.h>
#import "App.h"

@interface CangKuCollectionViewController ()

//App数据
@property (nonatomic, strong) NSArray *Apps;

//刷新
@property (nonatomic, strong)MJRefreshNormalHeader *mjHeader;
@property (nonatomic, strong)MJRefreshAutoNormalFooter *mjFooter;

@end

@implementation CangKuCollectionViewController

- (NSArray *)Apps{
    
    if (!_Apps){
        NSMutableArray *arr = [NSMutableArray array];
        [Http requesetWithUrl:@"http://www.moxcomic.com:23333/Store/getApp" params:nil sucess:^(id responseObject) {
            App *app = [App yy_modelWithJSON:responseObject];
            for (int i = 0; i < app.apps.count; i++) {
                [arr addObject:app.apps[i]];
            }
            _Apps = arr;
            //结束刷新状态
            [self.mjHeader endRefreshing];
            
        } failure:^(id responseObject) {
            NSLog(@"%@",responseObject);
        }];
    }
    return _Apps;
}

//重用Id
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjRefreshData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mjHeader.automaticallyChangeAlpha = YES;
    // 隐藏时间
    self.mjHeader.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态,就是马上执行mjRefreshData方法
    [self.mjHeader beginRefreshing];
    self.collectionView.mj_header = self.mjHeader;
    
    self.mjFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjLoadMoreData)];
    self.collectionView.mj_footer = self.mjFooter;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - MJRefreshHeader
- (void)mjRefreshData {
    _Apps = [self Apps];
    [self.mjHeader endEditing:YES];
    [self.collectionView reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.Apps.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/2-10, self.view.frame.size.height/3-10);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
