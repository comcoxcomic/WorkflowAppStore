//
//  ViewController.m
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/17.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "ViewController.h"
#import "AppView.h"
#import "App.h"

@interface ViewController ()
//用来存储应用数据
@property (nonatomic,strong) NSArray *apps;
@property (weak, nonatomic) IBOutlet UITableView *MainView;
- (IBAction)TabSelect:(id)sender;
@property (weak,nonatomic) UIView *aboutView;
@end

@implementation ViewController

//重写Get方法进行加载数据
- (NSArray *)apps
{
    if (_apps == nil)
    {
        NSArray *arr = [self getHTML];
        NSMutableArray *arrModels = [NSMutableArray array];
        for (NSDictionary *dict in arr)
        {
            App *model = [App appWithDictionary:dict];
            [arrModels addObject:model];
        }
        _apps = arrModels;
    }
    return  _apps;
}

-(NSArray *)getHTML
{
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://www.moxcomic.com:2333/Store/GetAll"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    return [self dictionaryWithJsonString:str][@"All"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getHTML];
    
    /*
     self 要遵循 UITableViewDelegate和UITableViewDelegate两个代理
     注意第11行
     */
    
    self.MainView.dataSource = self;
    self.MainView.delegate = self;
    
    //[self loadApps];
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
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //@"identifier"是一个标识 dequeueReusableCellWithIdentifier这个方法会重用单元格,单元格必须要重用不然单元格多了 内存消耗会特别大 用这种方式变的只是数据 单元格到一定数量之后就不会再创建了
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
        
        //这里注意啊 涉及到表格重用的问题 如果写在这里数字顺序会出现混乱 之所以会这样是因为单元格被重用了
        //cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        App *appModel = self.apps[indexPath.row];
        
        AppView *appView = [AppView appView];
        
        appView.model = appModel;
        
        [cell addSubview:appView];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (IBAction)TabSelect:(id)sender {
    UISegmentedControl *Seg = sender;
    NSInteger Index = Seg.selectedSegmentIndex;
    if (Index == 0)
    {
        [UIView animateWithDuration:1 animations:^{
            self.aboutView.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished)
            {
                [self.aboutView removeFromSuperview];
                self.aboutView = nil;
            }
        }];
    }
    else
    {
        if (self.aboutView == nil)
        {
            AppView *aboutView = [AppView aboutView];
            aboutView.frame = self.MainView.frame;
            aboutView.alpha = 0;
            self.aboutView = aboutView;
            [self.view addSubview:aboutView];
            [UIView animateWithDuration:1 animations:^{
                aboutView.alpha = 1;
            }];
        }
    }
}
@end
