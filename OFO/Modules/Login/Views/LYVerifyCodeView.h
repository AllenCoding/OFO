//
//  LYVerifyCodeView.h
//  OFO
//
//  Created by tianqiuqiu on 2017/10/31.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LYVerifyCodeView : UIView

@property(nonatomic,copy)NSMutableString*code;

-(void)changeVerifyCode;

@end
