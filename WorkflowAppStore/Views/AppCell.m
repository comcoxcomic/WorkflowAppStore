//
//  AppCell.m
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/25.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppCell.h"
#import <UIButton+AFNetworking.h>

@interface AppCell()
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblDownloadCount;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@property (weak, nonatomic) IBOutlet UIButton *imageIcon;
- (IBAction)btnShowInformation:(id)sender;

@end

@implementation AppCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(Apps *)model {
    _model = model;
    self.imageIcon.layer.cornerRadius = self.imageIcon.frame.size.width / 2;
    self.imageIcon.layer.masksToBounds = YES;
//    if (model.Pic != nil)
//    {
//        [self downloadImageWithUrl:model.Pic];
//        //        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];
//        //        self.imageIcon.image = image;
//    }
    [self.imageIcon setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.picURL] placeholderImage:[UIImage imageNamed:@"timg"]];
    //[self.imageIcon setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.Pic] placeholderImage:[UIImage imageNamed:@"timg"]];
    self.lblName.text = [NSString stringWithFormat:@"%@",model.name];
    self.lblAuthor.text = [NSString stringWithFormat:@"%@",model.qq];
    self.lblVersion.text = [NSString stringWithFormat:@"%@",model.ver];
    self.lblDownloadCount.text = [NSString stringWithFormat:@"%ld 次",(long)model.downloadCount];
}

//-(void)downloadImageWithUrl:(NSString *)imageDownloadURLStr{
//    //以便在block中使用
//    __block UIImage *image = [[UIImage alloc] init];
//    //图片下载链接
//    NSURL *imageDownloadURL = [NSURL URLWithString:imageDownloadURLStr];
//
//    //将图片下载在异步线程进行
//    //创建异步线程执行队列
//    dispatch_queue_t asynchronousQueue = dispatch_queue_create("imageDownloadQueue", NULL);
//    //创建异步线程
//    dispatch_async(asynchronousQueue, ^{
//        //网络下载图片  NSData格式
//        NSError *error;
//        NSData *imageData = [NSData dataWithContentsOfURL:imageDownloadURL options:NSDataReadingMappedIfSafe error:&error];
//        if (imageData) {
//            image = [UIImage imageWithData:imageData];
//        }
//        //回到主线程更新UI
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.imageIcon setImage:image forState:UIControlStateNormal];
//        });
//    });
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (IBAction)btnShowInformation:(id)sender {
    UIAlertController *actr = [UIAlertController alertControllerWithTitle:@"标题" message:@"这里是详细信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这里面是点击“确定“按钮后的操作
    }];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //这里面是点击”取消“按钮后的操作
    }];
    [actr addAction:ac];  //要把操作添加到UIAlertController中
    [actr addAction:ac1];
    //这里的self必须是一个 基于UIViewController的类的实例
    UIViewController *controller = [self getViewControllerWithView:self];
    [controller presentViewController:actr animated:YES completion:^{
        //这里是提示框消失后的操作
    }];
}
@end
