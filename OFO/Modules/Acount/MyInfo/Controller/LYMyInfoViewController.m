//
//  LYMyInfoViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYMyInfoViewController.h"
#import "LYSettingViewController.h"
#import "LYScoreViewController.h"
#import "LYSetNickNameViewController.h"
#import "LYChangePhoneViewController.h"
#import "LYCustomAlertView.h"

#define HomePath    [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface LYMyInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,LYCustomAlertViewDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contant_Y;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *scoreBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *carLabel;
@property (strong, nonatomic) IBOutlet UILabel *roleLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *wechatLabel;
@property (strong, nonatomic) IBOutlet UILabel *QqLabel;
@property(nonatomic,strong)UIImagePickerController*imagePicker;
@property(nonatomic,strong)LYCustomAlertView*sexAlert;
@property(nonatomic,strong)LYCustomAlertView*dateAlert;

@end

@implementation LYMyInfoViewController

#pragma mark Lazy Load
-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.allowsEditing=YES;
        _imagePicker.delegate=self;
    }
    return _imagePicker;
}

-(LYCustomAlertView *)dateAlert{
    if (!_dateAlert) {
        _dateAlert=[[LYCustomAlertView alloc]init];
        _dateAlert.style=LYCustomAlertViewDateAlertStyle;
        _dateAlert.delegate=self;
    }
    return _dateAlert;
}

-(LYCustomAlertView *)sexAlert{
    if (!_sexAlert) {
        _sexAlert=[[LYCustomAlertView alloc]init];
        _sexAlert.delegate=self;
        _sexAlert.dataSource=[NSMutableArray arrayWithObjects:@"男",@"女", nil];
    }
    return _sexAlert;
}


#pragma mark Life-cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";
    [self setNavgationBarItemWithImageName:@"Account_setting" WithSelector:@selector(ClickOnSetting) direction:NavgationBarItemRightDirection];
    [self addListener];
    [self viewLayoutUI];
    
}

- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag==0) {
        //昵称
        LYSetNickNameViewController*nVc=[[LYSetNickNameViewController alloc]init];
        nVc.nameBlcok = ^(NSString *nickname) {
         self.nickNameLabel.text=[nickname isPhone]?[nickname stringByReplacingOccurrencesOfString:[nickname substringWithRange:NSMakeRange(3, 4)] withString:@"****"]:nickname;
        };
        [self.navigationController pushViewController:nVc animated:YES];
    }else if (sender.tag==1){
        //性别
        [self presentViewController:self.sexAlert animated:YES completion:nil];

    }else if (sender.tag==2){
        //生日
        [self presentViewController:self.dateAlert animated:YES completion:nil];
        
    }else if (sender.tag==3){
        //认证
        [MBProgressHUD showError:@"暂未开放"];
    }else if (sender.tag==4){
        //手机号
        LYChangePhoneViewController*pVc=[[LYChangePhoneViewController alloc]init];
        [self.navigationController pushViewController:pVc animated:YES];
    }else if (sender.tag==5){
        //微信
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"“ofo”想要打开“微信”" message:@"绑定微信后，下次可直接使用该账号登录，免去手机号登录等待验证的时间，快人一步" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        UIAlertAction*logoutAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:cancel];
        [alert addAction:logoutAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if (sender.tag==6){
        //QQ
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"“ofo”想要打开“QQ”" message:@"绑定QQ后，下次可直接使用该账号登录，免去手机号登录等待验证的时间，快人一步" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        UIAlertAction*logoutAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:cancel];
        [alert addAction:logoutAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if (sender.tag==7){
        //头像
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction*lib=[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
            
        }];
        UIAlertAction*carmare=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }];
        UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alert addAction:carmare];
        [alert addAction:lib];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
            
    }else{
        //积分
        LYScoreViewController*sVc=[[LYScoreViewController alloc]init];
        [self.navigationController pushViewController:sVc animated:YES];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString*iconStr=[NSString stringWithFormat:@"default_%@.png",userPhoneNumber];
    [self saveImage:image withName:iconStr];
    [[LYDataManager shareManager]updateUserInfoWithKey:@"userHead" AndValue:iconStr];
    self.headView.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,iconStr]];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}
#pragma mark LYCustomAlertViewDelegate
-(void)LYCustomAlertView:(LYCustomAlertView *)alertView didSelectAlertResult:(NSString *)result{
    if (alertView==self.sexAlert) {
        self.sexLabel.text=result;
        [[LYDataManager shareManager] updateUserInfoWithKey:@"userSex" AndValue:result];
    }else{
        self.birthdayLabel.text=result;
        [[LYDataManager shareManager] updateUserInfoWithKey:@"userBirthday" AndValue:result];
    }
}

/*右上角按钮点击事件*/
-(void)ClickOnSetting{
    LYSettingViewController*setVc=[[LYSettingViewController alloc]init];
    [self.navigationController pushViewController:setVc animated:YES];
}
/*机型适配*/
-(void)viewLayoutUI{
    LYLog(@"我的plist文件的号码----%@",userPhoneNumber);

    if (IPHONE_5_5S) {
        self.contant_Y.constant=150;
    }else if (IPHONE_6_6S){
        self.contant_Y.constant=100;
    }else if (iPhoneX){
        self.contant_Y.constant=50;
    }else if (IPHONE_6P_6PS){
        self.contant_Y.constant=80;
    }
    self.phoneLabel.text=[userPhoneNumber stringByReplacingOccurrencesOfString:[userPhoneNumber substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
    self.nickNameLabel.text=[[[LYDataManager shareManager] userInfo].userNickname isPhone]?[[[LYDataManager shareManager] userInfo].userNickname stringByReplacingOccurrencesOfString:[[[LYDataManager shareManager] userInfo].userNickname substringWithRange:NSMakeRange(3, 4)] withString:@"****"]:[[LYDataManager shareManager] userInfo].userNickname;
    self.titleNameLabel.text=[userPhoneNumber stringByReplacingOccurrencesOfString:[userPhoneNumber substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
    if ([[[LYDataManager shareManager] userInfo].userHead isEqualToString:@""]) {
        self.headView.image=[UIImage imageNamed:@"Account_default"];
    }else{
        self.headView.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",HomePath, [[LYDataManager shareManager] userInfo].userHead]];
    }
    self.sexLabel.text=[[LYDataManager shareManager] userInfo].userSex;
    self.birthdayLabel.text=[[LYDataManager shareManager] userInfo].userBirthday;
    self.carLabel.text=@"未完成";
    self.roleLabel.text=[[LYDataManager shareManager] userInfo].userRole;
    self.wechatLabel.text=[[LYDataManager shareManager] userInfo].userWechat;
    self.QqLabel.text=[[LYDataManager shareManager] userInfo].userQQ;
    [self.scoreBtn setTitle:[NSString stringWithFormat:@" 信用分 %@ >",[[LYDataManager shareManager] userInfo].userScore] forState:UIControlStateNormal];

}

-(void)addListener{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewLayoutUI) name:ResetPhoneSuccessNotification object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
