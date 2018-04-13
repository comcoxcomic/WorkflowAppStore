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
#import "AboutView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
//用来存储应用数据
@property (nonatomic,strong) NSArray *apps;
@property (weak, nonatomic) IBOutlet UITableView *MainView;
- (IBAction)TabSelect:(id)sender;
@property (nonatomic, strong) UIView *aboutView;
@end

@implementation ViewController

- (UIView *)aboutView {
    if (_aboutView == nil) {
        _aboutView = [[AboutView alloc] initWithFrame:self.MainView.frame];
        _aboutView.alpha = 0;
        [self.view addSubview:_aboutView];
    }
    return _aboutView;
}

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
    } failure:^(id responseObject) {
        NSLog(@"%@",responseObject);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRules];
    //self.MainView.rowHeight = 200;
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
    cell.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        cell.alpha = 1;
    }];
}

- (IBAction)TabSelect:(id)sender {
    UISegmentedControl *Seg = sender;
    NSInteger Index = Seg.selectedSegmentIndex;
    if (Index == 0)
    {
//        self.aboutView.hidden = YES;
//        self.MainView.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            self.aboutView.alpha = 0;
            self.MainView.alpha = 1;
        }];
    }
    else
    {
//        self.aboutView.hidden = NO;
//        self.MainView.hidden = YES;
        [UIView animateWithDuration:1 animations:^{
            self.aboutView.alpha = 1;
            self.MainView.alpha = 0;
        }];
    }
}
@end
