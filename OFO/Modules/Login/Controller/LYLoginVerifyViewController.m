//
//  LYLoginVerifyViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/31.
//  Copyright © 2017年 OFO. All rights reserved.
//
#import "LYVerifyCodeView.h"
#import "LYLoginViewController.h"
#import "LYLoginVerifyViewController.h"
#import "InputCodeView.h"

@interface LYLoginVerifyViewController ()<InputViewDelegate>

@property (strong, nonatomic) IBOutlet InputCodeView *leftCodeView;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;
@property (strong, nonatomic) IBOutlet LYVerifyCodeView *codeView;

@property(nonatomic,assign)NSInteger num;
@property(nonatomic,assign)NSInteger codeLength;
@property(nonatomic,copy)NSString*verifyCode;

@end

@implementation LYLoginVerifyViewController


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.leftCodeView.textField resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.leftCodeView clear];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.num=0;
    self.refreshButton.layer.borderWidth=1;
    self.refreshButton.layer.borderColor=ColorWithRGB(219, 219, 219).CGColor;
    self.leftCodeView.textField.userInteractionEnabled=NO;
    self.leftCodeView.secureTextEntry= NO;
    self.leftCodeView.delegate=self;
    self.leftCodeView.numberOfVertificationCode=4;
    
}

-(void)didFinishCode:(NSString*)code{
    self.codeTF.placeholder=code.length>0?@"":@"输入右边数字";
    if (code.length>3) {
        if ([code isEqualToString:self.codeView.code]) {
            LYLoginViewController*loginVc=[[LYLoginViewController alloc]init];
            loginVc.phone=self.phoneTF.text;
            [[NSUserDefaults standardUserDefaults]setObject:[self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"userPhone"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:loginVc animated:YES];
        }else{
            self.codeLength=0;
            [self.leftCodeView clear];
        }
    }
}

- (IBAction)textFieldDidEditing:(UITextField *)sender {
    if (sender == self.phoneTF) {
        if (sender.text.length > self.num) {
            if (sender.text.length == 4 || sender.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:sender.text];
                [str insertString:@" " atIndex:(sender.text.length-1)];
                sender.text = str;
            }if (sender.text.length >= 13 ) {//输入完成
                sender.text = [sender.text substringToIndex:13];
                if ([[self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""] isPhone]) {
                    [self.phoneTF resignFirstResponder];
                    self.leftCodeView.textField.userInteractionEnabled=YES;
                    [self.leftCodeView.textField becomeFirstResponder];
                }else{
                    [MBProgressHUD showError:@"请输入正确的手机号"];
                }
            }
            self.num = sender.text.length;

        }else if (sender.text.length < self.num){//删除
            if (sender.text.length == 4 || sender.text.length == 9) {
                sender.text = [NSString stringWithFormat:@"%@",sender.text];
                sender.text = [sender.text substringToIndex:(sender.text.length-1)];
            }
            self.num= sender.text.length;
            self.leftCodeView.textField.userInteractionEnabled=NO;

        }
    }
}

- (IBAction)refreshCode:(UIButton *)sender {
    [self.codeView changeVerifyCode];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.leftCodeView.textField resignFirstResponder];
    [self.phoneTF resignFirstResponder];
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
