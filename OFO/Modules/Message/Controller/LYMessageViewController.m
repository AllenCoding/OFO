//
//  LYMessageViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/27.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYMessageViewController.h"
#import "LYInviteViewController.h"
#import "LYCouponViewController.h"


@interface LYMessageViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UILabel *pageLabel;
@property(nonatomic,strong)UIScrollView*picSv;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property(nonatomic,strong)NSArray*images;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contantY;



@end

@implementation LYMessageViewController

-(NSArray *)images{
    if (!_images) {
        _images=@[@"pic_1",@"pic_2",@"pic_3",@"pic_4",@"pic_5"];
    }
    return _images;
}

-(UIScrollView *)picSv{
    if (!_picSv) {
        _picSv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 0.28*ScreenHeight)];
        _picSv.delegate=self;
        _picSv.contentSize=CGSizeMake(Screenwidth*5, 0.28*ScreenHeight);
        _picSv.contentOffset=CGPointMake(0, 0);
        _picSv.pagingEnabled=YES;
        _picSv.showsVerticalScrollIndicator=NO;
        _picSv.showsHorizontalScrollIndicator=NO;
        for (int i=0; i<self.images.count; i++) {
            UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake(10+i*Screenwidth, 5, Screenwidth-20, 0.28*ScreenHeight-10)];
            icon.image=[UIImage imageNamed:self.images[i]];
            icon.layer.cornerRadius=5;
            icon.layer.masksToBounds=YES;
            [_picSv addSubview:icon];
        }
    }
    return _picSv;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.backgroundView addSubview:self.picSv];
    [self setNavgationBarItemWithImageName:@"" WithSelector:nil direction:NavgationBarItemLeftDirection];
    [self setNavgationBarItemWithImageName:@"Home_close" WithSelector:@selector(popBack) direction:NavgationBarItemRightDirection];
    if (IPHONE_5_5S) {
        self.contantY.constant=100;
    }else if (IPHONE_6_6S){
        self.contantY.constant=70;
    }else if (iPhoneX){
        self.contantY.constant=30;
    }else if (IPHONE_6P_6PS){
        self.contantY.constant=50;
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag==1) {
        LYInviteViewController*ivc=[[LYInviteViewController alloc]init];
        [self.navigationController pushViewController:ivc animated:YES];
        
    }else if (sender.tag==2){
        LYCouponViewController*cvc=[[LYCouponViewController alloc]init];
        [self.navigationController pushViewController:cvc animated:YES];
    }else{
       
        
    }

}

-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.sv) {
        if (scrollView.contentOffset.y>50) {
            self.title=@"我的消息";
        }else{
            self.title=@"";
        }
    }else{
        self.pageLabel.text=[NSString stringWithFormat:@"%.f/%ld",(scrollView.contentOffset.x/Screenwidth)+1,self.images.count];
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
