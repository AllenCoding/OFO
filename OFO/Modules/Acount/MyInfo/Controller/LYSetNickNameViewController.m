//
//  LYSetNickNameViewController.m
//  OFO
//
//  Created by LiuYong on 2017/11/2.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYSetNickNameViewController.h"

@interface LYSetNickNameViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nicknameTF;

@end

@implementation LYSetNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"修改昵称";
    self.view.backgroundColor=ColorWithRGB(242, 242, 242);
    [self setNavgationBarItemWithTitle:@"保存" titleColor:[UIColor blackColor] Font:DefalutFont(13) WithSelector:@selector(save) direction:NavgationBarItemRightDirection];
}
-(void)save{
    if (self.nicknameTF.text.length) {
        if (self.nameBlcok) {
            self.nameBlcok(self.nicknameTF.text);
            [[LYDataManager shareManager]updateUserInfoWithKey:@"userNickname" AndValue:self.nicknameTF.text];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [MBProgressHUD showError:@"昵称不能为空"];
    }
}

- (IBAction)nickNameTextFieldDidEditing:(UITextField *)sender {
    if (sender.text.length>17) {
        sender.text = [sender.text substringToIndex:15];
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
