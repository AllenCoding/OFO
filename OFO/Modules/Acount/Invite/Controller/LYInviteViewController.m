//
//  LYInviteViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYInviteViewController.h"
@interface LYInviteViewController ()
@property (strong, nonatomic) IBOutlet UILabel *inviteCodeLabel;

@end

@implementation LYInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"邀请好友";
    self.inviteCodeLabel.text=[NSString stringWithFormat:@"你的邀请码:%@",userPhoneNumber];
    
}

- (IBAction)shareToPlatform:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self alertWithTitle:@"微信"];
            break;
        case 1:
            [self alertWithTitle:@"微信"];
            break;
        case 2:
            [self alertWithTitle:@"QQ"];
            break;
        case 3:
            [self alertWithTitle:@"QQ"];
            break;
        default:
            [MBProgressHUD showSuccess:@"规则"];
            break;
    }
}

-(void)alertWithTitle:(NSString*)title{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"“ofo共享单车”想要打开“%@”",title]message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    UIAlertAction*logoutAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [alert addAction:logoutAction];
    [self presentViewController:alert animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
