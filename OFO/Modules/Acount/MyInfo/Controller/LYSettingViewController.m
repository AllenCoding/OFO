//
//  LYSettingViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/31.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYSettingViewController.h"
#import "LYMainViewController.h"
#import "LYNavgationController.h"

@interface LYSettingViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UIButton *logout;
@property (strong, nonatomic) IBOutlet UISwitch *messageSw;
@property (strong, nonatomic) IBOutlet UISwitch *paySw;
@property (strong, nonatomic) IBOutlet UILabel *cacheLabel;

@property (strong, nonatomic) IBOutlet UIView *manageView;



@end

@implementation LYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    [self.view insertSubview:self.logout aboveSubview:self.sv];
    self.paySw.on=[[[LYDataManager shareManager] userInfo].userAutoPay integerValue];
    self.messageSw.on=[[[LYDataManager shareManager] userInfo].userMessageAlert integerValue];
    self.manageView.hidden=![userPhoneNumber isEqualToString:@"18302214098"];
}

- (IBAction)logout:(UIButton *)sender {
    LYLog(@"点击我了");
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"确定退出吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    UIAlertAction*logoutAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        LYMainViewController*mainVc=[[LYMainViewController alloc]init];
        LYNavgationController*nav=[[LYNavgationController alloc]initWithRootViewController:mainVc];
        [UIApplication sharedApplication].keyWindow.rootViewController=nav;
    }];
    
    [alert addAction:cancel];
    [alert addAction:logoutAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (IBAction)messageAlert:(UISwitch *)sender {

    if (!sender.on) {
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"关闭后,你将无法收到行程结束提醒，确定要关闭吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            sender.on=YES;
            return ;
        }];
        UIAlertAction*logoutAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[LYDataManager shareManager]updateUserInfoWithKey:@"userMessageAlert" AndValue:@"0"];
        }];
        
        [alert addAction:cancel];
        [alert addAction:logoutAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        [[LYDataManager shareManager]updateUserInfoWithKey:@"userMessageAlert" AndValue:@"1"];

    }

}
- (IBAction)autoPay:(UISwitch *)sender {
  
    sender.on=!sender.on;
    NSString*pay=sender.on?@"1":@"0";
    [[LYDataManager shareManager]updateUserInfoWithKey:@"userAutoPay" AndValue:pay];

}
- (IBAction)cellAction:(UIButton *)sender {
    if (sender.tag==999) {
        LYLog(@"清除缓存");

    }else{
        LYLog(@"关于我们");

    }
}

- (IBAction)manage:(UIButton *)sender {
    //
    
}



#pragma mark 管理员操作



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
