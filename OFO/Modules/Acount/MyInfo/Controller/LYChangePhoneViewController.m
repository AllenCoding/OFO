//
//  LYChangePhoneViewController.m
//  OFO
//
//  Created by LiuYong on 2017/11/2.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYChangePhoneViewController.h"
#import "LYPhoneVerifyViewController.h"

@interface LYChangePhoneViewController ()
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation LYChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"手机号";
    NSMutableString*phone=[NSMutableString stringWithFormat:@"%@",userPhoneNumber];
    [phone insertString:@" " atIndex:3];
    [phone insertString:@" " atIndex:8];
    self.phoneLabel.text=phone;

}
- (IBAction)changePhoneNumber:(UIButton *)sender {
    LYPhoneVerifyViewController*pVc=[[LYPhoneVerifyViewController alloc]init];
    [self.navigationController pushViewController:pVc animated:YES];
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
