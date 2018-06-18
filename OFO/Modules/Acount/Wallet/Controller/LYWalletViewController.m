//
//  LYWalletViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYWalletViewController.h"
#import "LYRedPacketViewController.h"
#import "LYBarginViewController.h"
#import "LYBalanceViewController.h"
#import "LYDepositViewController.h"

@interface LYWalletViewController ()

@property (strong, nonatomic) IBOutlet UILabel *feeLabel;
@property (strong, nonatomic) IBOutlet UILabel *redpacketLabel;
@property (strong, nonatomic) IBOutlet UILabel *couponLabel;
@property (strong, nonatomic) IBOutlet UILabel *depositLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contantY;

@end

@implementation LYWalletViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    if (IPHONE_5_5S) {
        self.contantY.constant=50;
    }else if (IPHONE_6_6S){
        self.contantY.constant=20;
    }else if (iPhoneX){
        self.contantY.constant=0;
    }else if (IPHONE_6P_6PS){
        self.contantY.constant=10;
    }
}
- (IBAction)didSelectAtIndex:(UIButton *)sender {
    if (sender.tag==1) {
        LYBalanceViewController*bVc=[[LYBalanceViewController alloc]init];
        [self.navigationController pushViewController:bVc animated:YES];
    }else if (sender.tag==2){
        LYRedPacketViewController*rVc=[[LYRedPacketViewController alloc]init];
        [self.navigationController pushViewController:rVc animated:YES];
    }else if (sender.tag==3){
        LYBarginViewController*bVc=[[LYBarginViewController alloc]init];
        [self.navigationController pushViewController:bVc animated:YES];
    }else{
        LYDepositViewController*dVc=[[LYDepositViewController alloc]init];
        [self.navigationController pushViewController:dVc animated:YES];
    }
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
