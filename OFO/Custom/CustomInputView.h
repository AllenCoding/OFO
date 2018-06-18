//
//  CustomInputView.h
//  CropProduct
//
//  Created by LiuYong on 2017/8/10.
//  Copyright © 2017年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomInputView : UITextView
@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
-(void)textChanged:(NSNotification*)notification;

@end
