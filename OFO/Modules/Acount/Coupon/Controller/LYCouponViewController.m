//
//  LYCouponViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYCouponViewController.h"

@interface LYCouponViewController ()
@property (strong, nonatomic) IBOutlet UIView *codeView;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation LYCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"输入优惠码";
    self.codeView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.codeView.layer.borderWidth=1;
    
}
- (IBAction)onClick:(UIButton *)sender {
    if (self.codeTF.text.length) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [MBProgressHUD showError:@"请输入优惠码"];
    }
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
