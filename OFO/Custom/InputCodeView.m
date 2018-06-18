//
//  InputCodeView.m
//  CropProduct
//
//  Created by LiuYong on 2017/7/3.
//  Copyright © 2017年 LiuYong. All rights reserved.
//

#import "InputCodeView.h"
#import "InputLabel.h"

@interface InputCodeView ()<UITextFieldDelegate>

/**验证码/密码输入框的背景图片*/

@property(nonatomic, strong) UIImageView *backgroundImageView;

/**实际用于显示验证码/密码的label*/

@property(nonatomic, strong) InputLabel *label;

@end

@implementation InputCodeView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        //设置透明背景色，保证vertificationCodeInputView显示的frame为backgroundImageView的frame
        self.backgroundColor= [UIColor clearColor];
        //设置验证码/密码的位数默认为六位
        self.numberOfVertificationCode= 6;
        /*调出键盘的textField */
        self.textField= [[UITextField alloc] initWithFrame:self.bounds];
        //隐藏textField，通过点击VertificationCodeInputView使其成为第一响应者，来弹出键盘
        self.textField.hidden= YES;
        self.textField.keyboardType= UIKeyboardTypeNumberPad;
        self.textField.delegate= self;
        self.textField.font=BoldFontWithSize(18);
        //将textField放到最后边
        [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self insertSubview:self.textField atIndex:0];
        /*添加用于显示验证码/密码的label */
        self.label= [[InputLabel alloc] initWithFrame:self.bounds];
        self.label.numberOfVertificationCode= self.numberOfVertificationCode;
        self.label.secureTextEntry= self.secureTextEntry;
        self.label.font= self.textField.font;
        [self addSubview:self.label];
    }
    return self;
}


-(void)setBackgroudImageName:(NSString*)backgroudImageName {
    _backgroudImageName= backgroudImageName;
    //若用户设置了背景图片，则添加背景图片
    self.backgroundImageView= [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.image= [UIImage imageNamed:self.backgroudImageName];
    //将背景图片插入到label的后边，避免遮挡验证码/密码的显示
    [self insertSubview:self.backgroundImageView belowSubview:self.label];
    
}

-(void)setNumberOfVertificationCode:(NSInteger)numberOfVertificationCode
{
    _numberOfVertificationCode= numberOfVertificationCode;
    //保持label的验证码/密码位数与IDVertificationCodeInputView一致，此时label一定已经被创建
    self.label.numberOfVertificationCode= _numberOfVertificationCode;
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry= secureTextEntry;
    self.label.secureTextEntry= _secureTextEntry;
}

-(void)textFieldDidChange:(UITextField*)text{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didFinishCode:)]) {
        [self.delegate didFinishCode:self.vertificationCode];
    }
}


-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //判断是不是“删除”字符
    if(string.length != 0) {
        //不是“删除”字符//判断验证码/密码的位数是否达到预定的位数
        if(textField.text.length < self.numberOfVertificationCode) {
            self.label.text= [textField.text stringByAppendingString:string];
            self.vertificationCode= self.label.text;
            return YES;
        }
        else
        {
            return NO;
        }
    }else{
        //是“删除”字符
        self.label.text= [textField.text substringToIndex:textField.text.length - 1];
        self.vertificationCode= self.label.text;
        return YES;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch*> *)touches withEvent:(UIEvent *)event {
    
    self.textField.text=@"";
    self.label.text=@"";
    [self.textField becomeFirstResponder];
    
}

-(void)clear{
    self.textField.text=@"";
    self.label.text=@"";
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
