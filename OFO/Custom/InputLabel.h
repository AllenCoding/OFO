//
//  InputLabel.h
//  CropProduct
//
//  Created by LiuYong on 2017/7/3.
//  Copyright © 2017年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputLabel : UILabel

/**验证码/密码的位数*/
@property(nonatomic, assign) NSInteger numberOfVertificationCode;

/**控制验证码/密码是否密文显示*/
@property(nonatomic, assign) BOOL secureTextEntry;

@end
