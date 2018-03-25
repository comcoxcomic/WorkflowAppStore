//
//  AppCell.m
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/25.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppCell.h"
#import <UIButton+AFNetworking.h>
#import "Download.h"

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
    [self.imageIcon setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.picURL] placeholderImage:[UIImage imageNamed:@"NoImage"]];
    self.lblName.text = [NSString stringWithFormat:@"%@",model.name];
    self.lblAuthor.text = [NSString stringWithFormat:@"%@",model.qq];
    self.lblVersion.text = [NSString stringWithFormat:@"%@",model.ver];
    self.lblDownloadCount.text = [NSString stringWithFormat:@"%ld 次",(long)model.downloadCount];
}

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
    UIAlertController *actr = [UIAlertController alertControllerWithTitle:self.model.name message:self.model.des preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这里面是点击“确定“按钮后的操作
        [http requesetWithUrl:[NSString stringWithFormat:@"http://moxcomic.com:23333/Store/download?id=%ld",self.model.rowId] params:nil sucess:^(id responseObject) {
            Download *download = [Download yy_modelWithJSON:responseObject];
            if (download.code == 0)
            {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"workflow://import-workflow/?url=%@.wflow&name=%@&silent=true",download.downloadURL,self.model.name]]];
            }
            else
            {
                //无法找到该App下载地址
                UIAlertController *actr = [UIAlertController alertControllerWithTitle:self.model.name message:@"无法下载该应用" preferredStyle:UIAlertControllerStyleAlert];
                UIViewController *controller = [self getViewControllerWithView:self];
                UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //这里面是点击“确定“按钮后的操作
                }];
                [controller presentViewController:actr animated:YES completion:^{
                    //这里是提示框消失后的操作
                }];
                [actr addAction:ac];
            }
        } failure:^(id responseObject) {
            NSLog(@"%@",responseObject);
        }];
        
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
