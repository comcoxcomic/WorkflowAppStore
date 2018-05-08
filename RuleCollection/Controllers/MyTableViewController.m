//
//  MyTableViewController.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/5/7.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "MyTableViewController.h"
#import "LoginRootViewController.h"
#import "AppDelegate.h"

@interface MyTableViewController () <UITabBarControllerDelegate>
@property (nonatomic, assign) BOOL isLogin;
@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.delegate = self;
    
    if (!self.isLogin) {
        if (!self.isLogin) {
            [self showLoginVC];
        }
    }
}

- (void)loginWithUsername:(NSString *)userName password:(NSString *)password {
    
}

- (void)showLoginVC {
    //LoginViewController *lvc = [[LoginViewController alloc] init];
    
    //Storyboard里面创建的视图 你需要用下面这个方法从Storyboard里面取出来
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginRootViewController *lvc = (LoginRootViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginRootVCId"];
    lvc.Success = ^(BOOL isSuccess, NSString *userName){
        if (!isSuccess){
            //用户取消登录
            //self.tabBarController.selectedIndex = 0;
        }
        else {
            //登录成功
            self.isLogin = YES;
            
        }
    };
    [self presentViewController:lvc animated:YES completion:^{
        
    }];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (self.tabBarController.selectedIndex == 1) {
        [self showLoginVC];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
