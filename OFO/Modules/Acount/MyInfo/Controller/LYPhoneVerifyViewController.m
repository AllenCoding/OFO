//
//  LYPhoneVerifyViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/11/3.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYPhoneVerifyViewController.h"
#import "LYSetPhoneViewController.h"


@interface LYPhoneVerifyViewController ()

@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;


@end

@implementation LYPhoneVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ColorWithRGB(242, 242, 242);
    self.phoneTF.text=userPhoneNumber;
    self.title=@"手机号验证";
}

//获取验证码
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
                [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
                self.codeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
                [self.codeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%ds后重试", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
                [self.codeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.codeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)CodeTextFieldDidEditing:(UITextField *)sender {
    
    if (sender.text.length) {
        self.confirmBtn.enabled=YES;
        self.confirmBtn.backgroundColor=mainColor;
        
    }else{
        self.confirmBtn.enabled=NO;
        self.confirmBtn.backgroundColor=ColorWithRGB(219, 219, 219);
    }
}

//验证
- (IBAction)confirm:(UIButton *)sender {
    
    [SMSSDK commitVerificationCode:self.codeTF.text phoneNumber:userPhoneNumber zone:@"86" result:^(NSError *error) {
        if (!error) {
            LYSetPhoneViewController*sv=[[LYSetPhoneViewController alloc]init];
            [self.navigationController pushViewController:sv animated:YES];
        }else{
            [MBProgressHUD showError:@"验证码错误"];
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
