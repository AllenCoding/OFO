//
//  InputCodeView.h
//  CropProduct
//
//  Created by LiuYong on 2017/7/3.
//  Copyright © 2017年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputViewDelegate <NSObject>

-(void)didFinishCode:(NSString*)code;

@end

@interface InputCodeView : UIView

@property(nonatomic, copy) NSString *backgroudImageName;
/**验证码/密码的位数*/
@property(nonatomic, assign) NSInteger numberOfVertificationCode;
/**控制验证码/密码是否密文显示*/
@property(nonatomic, assign) BOOL secureTextEntry;
/**验证码/密码内容，可以通过该属性拿到验证码/密码输入框中验证码/密码的内容*/
@property(nonatomic, copy) NSString *vertificationCode;
/**用于获取键盘输入的内容，实际不显示*/

@property(nonatomic,weak)id<InputViewDelegate>delegate;

@property(nonatomic, strong) UITextField *textField;

-(void)clear;



@end
