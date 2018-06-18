//
//  LYInputView.m
//  OFO
//
//  Created by tianqiuqiu on 2017/11/9.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYInputView.h"

@interface LYInputView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *useButton;
@property (strong, nonatomic) IBOutlet UITextField *numberTF;
@property (strong, nonatomic) IBOutlet UIView *numberView;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong)NSMutableArray*nums;
@end


@implementation LYInputView

-(NSMutableArray *)nums{
    if (!_nums) {
        _nums=[NSMutableArray new];
    }
    return _nums;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"LYInputView" owner:self options:nil];
        [self addSubview:self.contentView];
//        [self.contentView addSubview:self.bottomView];
//        [self.contentView addSubview:self.topView];
        self.backgroundColor=[UIColor clearColor];
        self.useButton.layer.cornerRadius=20;
        self.numberView.layer.cornerRadius=20;
        self.numberView.layer.masksToBounds=YES;
        self.numberView.layer.borderWidth=2;
        self.numberView.layer.borderColor=mainColor.CGColor;
        
    }
    return self;
}
//输入操作
- (IBAction)inputNumberAction:(UIButton *)sender {
    
    [self.nums addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
    self.numberTF.text=[self.nums componentsJoinedByString:@""];
    [self check];

}
//删除操作
- (IBAction)deleteAction:(UIButton *)sender {
    
    [self.nums removeLastObject];
    self.numberTF.text=[self.nums componentsJoinedByString:@""];
    [self check];
}

- (IBAction)nextStep:(UIButton *)sender {
    
}
-(void)check{
    if (self.nums.count<1) {
        self.tipLabel.text=@"请确认输入了正确车牌号";
        self.useButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.useButton.enabled=NO;
        self.nextButton.enabled=NO;

    }else if (self.nums.count<4){
        self.tipLabel.text=@"车牌号一般为4~8位数字";
        self.useButton.enabled=YES;
        self.useButton.backgroundColor=mainColor;
        self.nextButton.enabled=YES;

    }else{
        self.tipLabel.text=@"温馨提示：若输错车牌号，将无法打开车锁";
        self.useButton.enabled=YES;
        self.useButton.backgroundColor=mainColor;
        self.nextButton.enabled=YES;
    }
}


-(void)dismissKeyboard{
    
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.contentView.frame=rect;

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
