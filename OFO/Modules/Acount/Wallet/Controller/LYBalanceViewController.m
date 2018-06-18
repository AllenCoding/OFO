//
//  LYBalanceViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/11/6.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYBalanceViewController.h"

@interface LYBalanceViewController ()

@end

@implementation LYBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"余额";
    [self setNavgationBarItemWithTitle:@"明细" titleColor:[UIColor blackColor] Font:DefalutFont(13) WithSelector:@selector(Detail) direction:NavgationBarItemRightDirection];
}
-(void)Detail{
    LYLog(@"点击明细");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
