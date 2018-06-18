//
//  LYLoginViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/31.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYLoginViewController.h"
#import "LYHomeViewController.h"
#import "InputCodeView.h"
#import "LYGuideView.h"

@interface LYLoginViewController ()<InputViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet InputCodeView *codeView;

@end

@implementation LYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneLabel.text=self.phone;
    self.loginBtn.backgroundColor=ColorWithRGB(219, 219, 219);    
    self.codeView.secureTextEntry= NO;
    self.codeView.delegate=self;
    self.codeView.numberOfVertificationCode=4;
    [self.codeView.textField becomeFirstResponder];
}

-(void)didFinishCode:(NSString*)code{
    if (code.length>3) {
        self.loginBtn.enabled=YES;
        self.loginBtn.backgroundColor=mainColor;

    }else{
        self.loginBtn.enabled=NO;
        self.loginBtn.backgroundColor=ColorWithRGB(219, 219, 219);
    }
}


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCode:(UIButton *)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:userPhoneNumber zone:@"86" result:^(NSError *error) {
        if (!error) {
            [MBProgressHUD showSuccess:@"已发送"];
        }else{
            [MBProgressHUD showError:@"发送失败"];
        }
    }];
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
                self.codeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
                [self.codeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"(%ds)", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
                [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                self.codeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)login:(UIButton *)sender {
    
    [SMSSDK commitVerificationCode:self.codeView.textField.text phoneNumber:userPhoneNumber zone:@"86" result:^(NSError *error) {
        if (!error) {
            [self.codeView.textField resignFirstResponder];
            [MBProgressHUD showMessage:@""];
            LYUser*user=[[LYUser alloc]init];
            if (![[LYDataManager shareManager]isExistWithPhone:userPhoneNumber]) {
                user.userEnable=@"1";
                user.userBirthday=@"未设置";
                user.userPhone=userPhoneNumber;
                user.userMessageAlert=@"1";
                user.userAutoPay=@"1";
                user.userStudent=@"非校园用户";
                user.userScore=@"100";
                user.userRole=@"注册用户";
                user.userWechat=@"未绑定";
                user.userQQ=@"未绑定";
                user.userHead=@"";
                user.userNickname=userPhoneNumber;
                user.lastLogin=[NSString currentTime:@"YYYY-MM-dd HH:mm:ss"];
                user.firstLogin=[NSString currentTime:@"YYYY-MM-dd HH:mm:ss"];
                user.userSex=@"男";
                [[LYDataManager shareManager]userRegsiter:user];
            }else{
                [[LYDataManager shareManager]updateUserInfoWithKey:@"lastLogin" AndValue:[NSString currentTime:@"YYYY-MM-dd HH:mm:ss"]];
            }
            [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
                [MBProgressHUD hideHUD];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                if (!isFirstInstall) {
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isFirstInstall"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    LYGuideView*gv=[[LYGuideView alloc]init];
                    NSMutableArray*arr=[NSMutableArray new];
                    arr=[NSMutableArray arrayWithObjects:@"guide_1",@"guide_2",@"guide_3",@"guide_4", nil];
                    gv.imagesArray=arr;
                    gv.block = ^{
                        LYHomeViewController*homeVc=[[LYHomeViewController alloc]init];
                        [self.navigationController pushViewController:homeVc animated:YES];
                    };
                    [self presentViewController:gv animated:NO completion:nil];
                    
                }else{
                    LYHomeViewController*homeVc=[[LYHomeViewController alloc]init];
                    [self.navigationController pushViewController:homeVc animated:YES];
                }
            }];
        
        }else{
            [MBProgressHUD showError:@"验证码错误"];
        }
        
    }];
}

- (IBAction)contact:(UIButton *)sender {
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
