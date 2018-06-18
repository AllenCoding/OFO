//
//  LYCodeView.m
//  OFO
//
//  Created by LiuYong on 2017/10/29.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYCodeView.h"

@interface LYCodeView()

@property(nonatomic,strong)UILabel*bikeCodeLabel;
@property(nonatomic,strong)UILabel*proLabel;

@end

@implementation LYCodeView

-(instancetype)initWithFrame:(CGRect)frame AndCodesArray:(NSMutableArray*)arr{
    self=[super initWithFrame:frame];
    if(self){
        [self setUpViewsWithArr:arr];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setUpViewsWithArr:(NSMutableArray*)arr{
    
    UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    topView.backgroundColor=[UIColor clearColor];
    [self addSubview:topView];
    
    UIImageView*bgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    bgView.image=[UIImage imageNamed:@"Home_top"];
    bgView.userInteractionEnabled=YES;
    [topView addSubview:bgView];
    
    UIView*bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bottomView];
    
    _bikeCodeLabel=[[UILabel alloc]initWithFrame:CGRectMake((Screenwidth-300)/2, 25, 300, 20)];
    _bikeCodeLabel.textColor=[UIColor blackColor];
    _bikeCodeLabel.font=BoldFontWithSize(20);
    _bikeCodeLabel.textAlignment=1;
    [topView addSubview:_bikeCodeLabel];
    
    _proLabel=[[UILabel alloc]initWithFrame:CGRectMake((Screenwidth-200)/2, 5, 200, 30)];
    _proLabel.textColor=[UIColor lightGrayColor];
    _proLabel.font=DefalutFont(14);
    _proLabel.textAlignment=1;
    _proLabel.text=@"如果车辆有问题，请报修";
    [bottomView addSubview:_proLabel];
    
    CGFloat labelWidth=(self.frame.size.width-2*20-10*3)/4;
    NSArray*images=@[@"Home_Torch",@"Home_Volum",@"Home_End",@"Home_Fix"];

    for (int i=0; i<arr.count; i++) {
        UILabel*numLabel=[[UILabel alloc]initWithFrame:CGRectMake(20+(labelWidth+10)*i, 50, labelWidth, labelWidth*1.3)];
        numLabel.textColor=[UIColor blackColor];
        numLabel.font=BoldFontWithSize(40);
        numLabel.textAlignment=1;
        numLabel.backgroundColor=mainColor;
        numLabel.text=arr[i];
        numLabel.layer.cornerRadius=10;
        numLabel.layer.masksToBounds=YES;
        [bottomView addSubview:numLabel];
        
        UIButton*operateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        operateBtn.frame=CGRectMake((Screenwidth-60*4)/5+(60+(Screenwidth-60*4)/5)*i, 50+labelWidth*1.3+20, 60, 60);
        operateBtn.tag=i;
        [operateBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [operateBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateHighlighted];
        [operateBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateSelected];
        [operateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [operateBtn addTarget:self action:@selector(clickByTag:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:operateBtn];
    }
}

-(void)clickByTag:(UIButton*)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(CodeView:didSelectAtIndex:)]) {
        [self.delegate CodeView:self didSelectAtIndex:sender.tag];
    }
}

-(void)setBikeCode:(NSString *)bikeCode{
    _bikeCode=bikeCode;
    self.bikeCodeLabel.text=[NSString stringWithFormat:@"No.%@的解锁码",bikeCode];
}

-(void)hide{
    [self removeFromSuperview];
}


@end
