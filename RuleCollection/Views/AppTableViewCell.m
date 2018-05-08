//
//  AppTableViewCell.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/4/13.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppTableViewCell.h"
#import "App.h"
#import "AppFrame.h"
#import "Download.h"
#import <UIImageView+AFNetworking.h>

#define textFont [UIFont systemFontOfSize:12]

@interface AppTableViewCell ()
@property (nonatomic, weak) UIImageView *imageViewIcon;
@property (nonatomic, weak) UILabel *lblAppName;
@property (nonatomic, weak) UILabel *lblAuthorQQ;
@property (nonatomic, weak) UILabel *lblAppVersion;
@property (nonatomic, weak) UILabel *lblAppDescription;
@property (nonatomic, weak) UIButton *btnInformation;
@property (nonatomic, weak) UIButton *btnAddRule;
@end

@implementation AppTableViewCell

- (void)setAppFrame:(AppFrame *)appFrame {
    _appFrame = appFrame;
    [self settingData];
    [self settingFrame];
}

- (void)settingData {
    Apps *model = self.appFrame.app;
    
    
    //根据不同的需求 导入不同的AFNetworking的控件头文件例如<UIButton+AFNetworking.h>、<UIImageView+AFNetworking.h>
    [self.imageViewIcon setImageWithURL:[NSURL URLWithString:model.AppPicUrl] placeholderImage:[UIImage imageNamed:@"NoImage"]];
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.picURL]]];
//    self.imageViewIcon.image = image;
    
    self.lblAppName.text = model.AppName;
    
    self.lblAuthorQQ.text = model.AuthorName;
    
    self.lblAppVersion.text = model.AppVersion;
    
    self.lblAppDescription.text = model.AppDescription;
}

- (void)settingFrame {
    
    self.imageViewIcon.frame = self.appFrame.appIconFrame;
    
    self.lblAppName.frame = self.appFrame.appNameFrame;
    
    self.lblAuthorQQ.frame = self.appFrame.authorQQFrame;
    
    self.lblAppVersion.frame = self.appFrame.appVersionFrame;
    
    self.lblAppDescription.frame = self.appFrame.appDescriptionFrame;
    
    self.btnInformation.frame = self.appFrame.btnShowInformationFrame;
    
    self.btnAddRule.frame = self.appFrame.btnAddRuleFrame;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imageViewIcon];
        self.imageViewIcon = imageViewIcon;
        
        UILabel *lblAppName = [[UILabel alloc] init];
        lblAppName.font = textFont;
        lblAppName.numberOfLines = 0;
        [self.contentView addSubview:lblAppName];
        self.lblAppName = lblAppName;
        
        UILabel *lblAuthorQQ = [[UILabel alloc] init];
        lblAuthorQQ.font = textFont;
        lblAuthorQQ.numberOfLines = 0;
        [self.contentView addSubview:lblAuthorQQ];
        self.lblAuthorQQ = lblAuthorQQ;
        
        UILabel *lblAppVersion = [[UILabel alloc] init];
        lblAppVersion.font = textFont;
        lblAppVersion.numberOfLines = 0;
        [self.contentView addSubview:lblAppVersion];
        self.lblAppVersion = lblAppVersion;
        
        UILabel *lblAppDescription = [[UILabel alloc] init];
        lblAppDescription.font = textFont;
        lblAppDescription.numberOfLines = 0;
        [self.contentView addSubview:lblAppDescription];
        self.lblAppDescription = lblAppDescription;
        
        UIButton *btnInformation = [[UIButton alloc] init];
        [btnInformation setTitle:@"详细信息" forState:UIControlStateNormal];
        [btnInformation setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnInformation setTitleColor: [UIColor grayColor] forState:UIControlStateHighlighted];
        [btnInformation.layer setBorderWidth:1.0];
        [btnInformation.layer setCornerRadius:10.0];
        [btnInformation.layer setMasksToBounds:YES];
        btnInformation.layer.borderColor = [UIColor blueColor].CGColor;
        [btnInformation addTarget:self action:@selector(showInformation) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btnInformation];
        self.btnInformation = btnInformation;
        
        UIButton *btnAddRule = [[UIButton alloc] init];
        [btnAddRule setTitle:@"添加规则" forState:UIControlStateNormal];
        [btnAddRule setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnAddRule setTitleColor: [UIColor grayColor] forState:UIControlStateHighlighted];
        [btnAddRule.layer setBorderWidth:1.0];
        [btnAddRule.layer setCornerRadius:10.0];
        [btnAddRule.layer setMasksToBounds:YES];
        btnAddRule.layer.borderColor = [UIColor blueColor].CGColor;
        [btnAddRule addTarget:self action:@selector(addRule) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btnAddRule];
        self.btnAddRule = btnAddRule;
        
    }
    return self;
}

- (void)addRule {
    [Http requesetWithUrl:[NSString stringWithFormat:@"http://moxcomic.com:23333/Store/download?id=%ld",(long)self.appFrame.app.rowId] params:nil sucess:^(id responseObject) {
        Download *download = [Download yy_modelWithJSON:responseObject];
        if (download.code == 0)
        {
            NSString *urlStr = [NSString stringWithFormat:@"workflow://import-workflow/?url=%@.wflow&name=%@&silent=true",download.AppUrl,[self.appFrame.app.AppName urlEncode]];
            NSURL *url = [NSURL URLWithString:urlStr];
            [[UIApplication sharedApplication]openURL:url];
        }
        else
        {
            //无法找到该App下载地址
            UIAlertController *actr = [UIAlertController alertControllerWithTitle:self.appFrame.app.AppName message:@"无法添加该应用" preferredStyle:UIAlertControllerStyleAlert];
            UIViewController *controller = [Util getViewControllerWithView:self];
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
}

- (void)showInformation {
    Apps *_model = self.appFrame.app;
    NSString *information = [NSString stringWithFormat:@"名称：%@\n作者QQ：%@\n版本：%@\n简介：%@",_model.AppName,_model.AuthorQQ,_model.AppVersion,_model.AppDescription];
    UIAlertController *actr = [UIAlertController alertControllerWithTitle:@"详细信息" message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这里面是点击“确定“按钮后的操作
    }];
    //    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //        //这里面是点击”取消“按钮后的操作
    //    }];
    [actr addAction:ac];  //要把操作添加到UIAlertController中
    //    [actr addAction:ac1];
    //这里的self必须是一个 基于UIViewController的类的实例
    UIViewController *controller = [Util getViewControllerWithView:self];
    [controller presentViewController:actr animated:YES completion:^{
        //这里是提示框消失后的操作
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
