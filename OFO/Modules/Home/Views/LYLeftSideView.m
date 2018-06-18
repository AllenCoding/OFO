//
//  LYLeftSideView.m
//  OFO
//
//  Created by LiuYong on 2017/10/28.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYLeftSideView.h"
#import "LYMyAccountCell.h"


@interface LYLeftSideView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView*topView;
@property(nonatomic,strong)UIView*bottomView;
@property(nonatomic,strong)UITableView*tabelView;
@property(nonatomic,strong)NSArray*datasource;
@property(nonatomic,strong)UIButton*closeBtn;
@property(nonatomic,strong)UIView*acountHeadView;

@end

@implementation LYLeftSideView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.tabelView];
        [self.topView addSubview:self.closeBtn];
    }
    return self;
}

#pragma mark Lazy Load

-(UIView *)topView{
    if (!_topView) {
        _topView=[[UIView alloc]initWithFrame:CGRectMake(0, -self.frame.size.height*0.4, self.frame.size.width, self.frame.size.height*0.4)];
        _topView.backgroundColor=mainColor;

    }
    return _topView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.85*self.frame.size.height)];
        _bottomView.backgroundColor=[UIColor whiteColor];

    }
    return _bottomView;
}

-(UIView *)acountHeadView{
    if (!_acountHeadView) {
        _acountHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, (120.0/568.0)*self.frame.size.height+30)];
        _acountHeadView.backgroundColor=[UIColor whiteColor];
        
        UIImageView*iconView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.6*(120.0/568.0)*self.frame.size.height)];
        iconView.image=[UIImage imageNamed:@"Home_head"];
        iconView.userInteractionEnabled=YES;
        [_acountHeadView addSubview:iconView];
        
        UIButton*headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.frame=CGRectMake(50, 0, 0.6*(120.0/568.0)*self.frame.size.height, 0.6*(120.0/568.0)*self.frame.size.height);
        headBtn.layer.masksToBounds=YES;
        [headBtn addTarget:self action:@selector(clickOnHead:) forControlEvents:UIControlEventTouchUpInside];
        headBtn.layer.cornerRadius=0.3*(120.0/568.0)*self.frame.size.height;
        [_acountHeadView addSubview:headBtn];
        
        UILabel*phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(50,  0.6*(120.0/568.0)*self.frame.size.height+20, 200, 30)];
        
        phoneLabel.text=[userPhoneNumber stringByReplacingOccurrencesOfString:[userPhoneNumber substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
        phoneLabel.textAlignment=NSTextAlignmentLeft;
        phoneLabel.textColor=[UIColor blackColor];
        phoneLabel.font=DefalutFont(18);
        [_acountHeadView addSubview:phoneLabel];
    
        UILabel*markLabel=[[UILabel alloc]initWithFrame:CGRectMake(50,  0.6*(120.0/568.0)*self.frame.size.height+20+25, 200, 30)];
        markLabel.text=[NSString stringWithFormat:@"已认证-信用分 %@",[[LYDataManager shareManager] userInfo].userScore];
        markLabel.textAlignment=NSTextAlignmentLeft;
        markLabel.textColor=[UIColor lightGrayColor];
        markLabel.font=DefalutFont(12);
        [_acountHeadView addSubview:markLabel];
        
    }
    return _acountHeadView;
}

-(UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height) style:UITableViewStylePlain];
        _tabelView.delegate=self;
        _tabelView.dataSource=self;
        _tabelView.scrollEnabled=YES;
        _tabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tabelView.scrollEnabled=NO;
        _tabelView.tableHeaderView=self.acountHeadView;
        
        UISwipeGestureRecognizer *swipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hideFromWindow)];
        swipe.direction =UISwipeGestureRecognizerDirectionDown;
        [_tabelView addGestureRecognizer:swipe];
      
    }
    return _tabelView;
}
-(NSArray *)datasource{
    if (!_datasource) {
        _datasource=@[[NSMutableDictionary dictionaryWithObjectsAndKeys:@"tour_image",@"image",@"我的行程",@"text",nil],[NSMutableDictionary dictionaryWithObjectsAndKeys:@"wallet_image",@"image",@"我的钱包",@"text",nil],[NSMutableDictionary dictionaryWithObjectsAndKeys:@"invite_image",@"image",@"邀请好友",@"text",nil],[NSMutableDictionary dictionaryWithObjectsAndKeys:@"coupon_image",@"image",@"兑优惠券",@"text",nil],[NSMutableDictionary dictionaryWithObjectsAndKeys:@"service_image",@"image",@"我的客服",@"text",nil]];
    }
    return _datasource;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame=CGRectMake(self.frame.size.width-50, 20, 40, 40);
        [_closeBtn addTarget:self action:@selector(Close:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:[UIImage imageNamed:@"Home_close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

#pragma mark Tableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LYMyAccountCell*cell=[LYMyAccountCell configCellWithTableView:tableView];
    cell.accountLabel.text=self.datasource[indexPath.row][@"text"];
    cell.iconView.image=[UIImage imageNamed:self.datasource[indexPath.row][@"image"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IPHONE_5_5S) {
        return 38;
    }else if (IPHONE_6_6S){
        return 45;
    }else if (IPHONE_4_4S){
        return 35;
    }else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(LYLeftSideView:didFinishSelectAtIndex:)]) {
        [self.delegate LYLeftSideView:self didFinishSelectAtIndex:indexPath.row];
    }
}
-(void)Close:(UIButton*)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(LYLeftSideView:didClickOnClose:)]) {
        [self.delegate LYLeftSideView:self didClickOnClose:button];
    }
}
-(void)clickOnHead:(UIButton*)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(LYLeftSideView:didClickOnHead:)]) {
        [self.delegate LYLeftSideView:self didClickOnHead:sender];
    }
}

-(void)showToWindow{
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.4);
        self.bottomView.frame=CGRectMake(0, self.frame.size.height*0.15,self.frame.size.width, self.frame.size.height*0.85);
    }];
}
-(void)hideFromWindow{
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.frame=CGRectMake(0, -self.frame.size.height*0.4, self.frame.size.width, self.frame.size.height*0.4);
        self.bottomView.frame=CGRectMake(0, self.frame.size.height,self.frame.size.width, self.frame.size.height*0.85);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
