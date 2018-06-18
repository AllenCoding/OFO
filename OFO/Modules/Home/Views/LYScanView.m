//
//  LYScanView.m
//  OFO
//
//  Created by LiuYong on 2017/10/28.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYScanView.h"

@interface LYScanView()
@property(nonatomic,strong)UIButton*topBtn;

@end

@implementation LYScanView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        
        [self setUpViews];
        
        self.backgroundColor=[UIColor clearColor];
        
        UISwipeGestureRecognizer*swipeDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(animationGesture:)];
        swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeDown];
        
        UISwipeGestureRecognizer*swipeUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(animationGesture:)];
        swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeUp];
    
        
    }
    return self;
}

-(void)setUpViews{
    
    UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    topView.backgroundColor=[UIColor clearColor];
    [self addSubview:topView];
    
    UIImageView*bgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    bgView.image=[UIImage imageNamed:@"Home_top"];
    bgView.userInteractionEnabled=YES;
    [topView addSubview:bgView];
    
    UIButton*topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame=CGRectMake((self.frame.size.width-40)/2, 5, 40, 40);
    [topBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [topBtn setImage:[UIImage imageNamed:@"Home_arrow_up"] forState:UIControlStateNormal];
    [topBtn setImage:[UIImage imageNamed:@"Home_arrow_down"] forState:UIControlStateSelected];
    topBtn.selected=YES;
    _topBtn=topBtn;
    [topView addSubview:topBtn];
    
    
    UIView*bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bottomView];
    
    UIButton*scanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame=CGRectMake((self.frame.size.width-Screenwidth/5*2)/2, 15, Screenwidth/5*2 , Screenwidth/5*2);
    [scanBtn addTarget:self action:@selector(scan:) forControlEvents:UIControlEventTouchUpInside];
    scanBtn.backgroundColor=mainColor;
    [scanBtn setImage:[UIImage imageNamed:@"Home_scan"] forState:UIControlStateNormal];
    [scanBtn setImage:[UIImage imageNamed:@"Home_scan"] forState:UIControlStateSelected];
    [scanBtn setImage:[UIImage imageNamed:@"Home_scan"] forState:UIControlStateHighlighted];
    [scanBtn setTitle:@"扫码用车" forState:UIControlStateNormal];
    scanBtn.titleLabel.font=DefalutFont(18);
    [scanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scanBtn.layer.cornerRadius=scanBtn.frame.size.width/2;
    scanBtn.layer.masksToBounds=YES;
    CGFloat offset = 25.0f;
    scanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -scanBtn.imageView.frame.size.width, -scanBtn.imageView.frame.size.height-offset/2, 0);
    scanBtn.imageEdgeInsets = UIEdgeInsetsMake(-scanBtn.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -scanBtn.titleLabel.intrinsicContentSize.width);
    [bottomView addSubview:scanBtn];

    UIButton*leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(10, bottomView.frame.size.height-60, 50 , 50);
    [leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"Home_account"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"Home_account"] forState:UIControlStateSelected];
    [leftBtn setImage:[UIImage imageNamed:@"Home_account"] forState:UIControlStateHighlighted];
    [bottomView addSubview:leftBtn];
    
    
    UIButton*rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(bottomView.frame.size.width-60, bottomView.frame.size.height-60, 50 , 50);
    [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"Home_message"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"Home_message"] forState:UIControlStateSelected];
    [rightBtn setImage:[UIImage imageNamed:@"Home_message"] forState:UIControlStateHighlighted];
    [bottomView addSubview:rightBtn];

}

-(void)animationGesture:(UISwipeGestureRecognizer*)swipe{
    BOOL isUp = false;
    if (swipe.direction==UISwipeGestureRecognizerDirectionUp) {
        if (!self.topBtn.selected) {
            self.topBtn.selected=YES;
            isUp=YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y-ScreenHeight/3, self.frame.size.width, self.frame.size.height);
            }];
        }
    }else{
        
        self.topBtn.selected=NO;
        isUp=NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y+ScreenHeight/3, self.frame.size.width, self.frame.size.height);
        }];
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scanViewAnimation:)]) {
        [self.delegate scanViewAnimation:isUp];
    }
}

-(void)show:(UIButton*)sender{
    sender.selected=!sender.selected;
    if(sender.selected){
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y-ScreenHeight/3, self.frame.size.width, self.frame.size.height);
        }];
            }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y+ScreenHeight/3, self.frame.size.width, self.frame.size.height);
        }];
    }
    if(self.delegate&&[self.delegate respondsToSelector:@selector(scanViewIsHide:)])
    [self.delegate scanViewIsHide:!sender.selected];
}
-(void)scan:(UIButton*)sender{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didClickScanAction)]){
        [self.delegate didClickScanAction];
    }
}
-(void)leftAction:(UIButton*)sender{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didSelectAccountAction)]){
        [self.delegate didSelectAccountAction];
    }
}
-(void)rightAction:(UIButton*)sender{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didSelectMessageAction)]){
        [self.delegate didSelectMessageAction];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
