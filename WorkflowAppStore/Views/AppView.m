//
//  AppView.m
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppView.h"
#import "App.h"
@interface AppView()
@property (weak, nonatomic) IBOutlet UIButton *imageIcon;
- (IBAction)btnShowInformation:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblDownload;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@end

@implementation AppView
- (void)setModel:(App *)model
{
    _model = model;
    self.imageIcon.layer.cornerRadius = self.imageIcon.frame.size.width / 2;
    self.imageIcon.layer.masksToBounds = YES;
    if (model.Pic != nil)
    {
        [self downloadImageWithUrl:model.Pic];
        //        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];
        //        self.imageIcon.image = image;
    }
    self.lblName.text = [NSString stringWithFormat:@"%@",model.Name];
    self.lblAuthor.text = [NSString stringWithFormat:@"%@",model.Author];
    self.lblVersion.text = [NSString stringWithFormat:@"%@",model.Version];
    self.lblDownload.text = [NSString stringWithFormat:@"%d 次",model.Download];
}

-(void)downloadImageWithUrl:(NSString *)imageDownloadURLStr{
    //以便在block中使用
    __block UIImage *image = [[UIImage alloc] init];
    //图片下载链接
    NSURL *imageDownloadURL = [NSURL URLWithString:imageDownloadURLStr];
    
    //将图片下载在异步线程进行
    //创建异步线程执行队列
    dispatch_queue_t asynchronousQueue = dispatch_queue_create("imageDownloadQueue", NULL);
    //创建异步线程
    dispatch_async(asynchronousQueue, ^{
        //网络下载图片  NSData格式
        NSError *error;
        NSData *imageData = [NSData dataWithContentsOfURL:imageDownloadURL options:NSDataReadingMappedIfSafe error:&error];
        if (imageData) {
            image = [UIImage imageWithData:imageData];
        }
        //回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageIcon setImage:image forState:UIControlStateNormal];
        });
    });
}

+ (instancetype)appView
{
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    return [[rootBundle loadNibNamed:@"AppView" owner:nil options:nil] firstObject];
}

+ (instancetype)aboutView
{
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    return [[rootBundle loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
}

- (IBAction)btnShowInformation:(id)sender
{
    UIAlertController *actr = [UIAlertController alertControllerWithTitle:self.model.Name message:self.model.Description preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这里面是点击“确定“按钮后的操作
        //创建一个url，这个url就是要打开程序的url schemes，记得加上：//
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"workflow://import-workflow/?url=%@.workflow&name=%@&silent=true",@"URL",self.model.Name]];
        
        //打开url
        [[UIApplication sharedApplication] openURL:url];
    }];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //这里面是点击”取消“按钮后的操作
    }];
    [actr addAction:ac];  //要把操作添加到UIAlertController中
    [actr addAction:ac1];
    //这里的self必须是一个 基于UIViewController的类的实例
    UIViewController *controller = [self getViewControllerWithView:self];
    if (controller != nil)
    {
        [controller presentViewController:actr animated:YES completion:^{
            //这里是提示框消失后的操作
        }];
    }
}

- (UIViewController *)getViewControllerWithView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
