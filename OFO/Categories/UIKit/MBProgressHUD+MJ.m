//
//  MBProgressHUD+MJ.m
//
//  Created by MJ Lee on 13/4/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"
#import "UIImage+GIF.H"
#define HudBackColor ColorWithRGB(230, 230, 230)
#define HudImageColor [UIColor whiteColor]
#define HudLabelColor [UIColor whiteColor]

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //在StatusBarHud 显示期间，由于lastObject的Frame的缘故将导致
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = HudBackColor;
    hud.contentColor = HudLabelColor;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

#pragma mark -显示自定义动画
+ (MBProgressHUD *)showGifToView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor clearColor];
    hud.label.textColor = HudLabelColor;
    hud.detailsLabel.textColor = HudLabelColor;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.backgroundColor = [UIColor clearColor];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // YES代表需要蒙版效果
//    hud.dimBackground = NO;
    return hud;
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //在StatusBarHud 显示期间，由于lastObject的Frame的缘故将导致
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];

    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.bezelView.color = HudBackColor;
    hud.label.textColor = HudLabelColor;
    hud.detailsLabel.textColor = HudLabelColor;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundColor = [UIColor colorWithRed:300/255.0 green:300/255.0 blue:300/255.0 alpha:0.1];
//    hud.dimBackground = NO;
    
//    // 设置图片
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 113)];
//    imageView.image = [UIImage sd_animatedGIFNamed:@"变色的鱼"];
//    hud.customView = imageView;
//    // 再设置模式
//    hud.mode = MBProgressHUDModeCustomView;
    return hud;
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //在StatusBarHud 显示期间，由于lastObject的Frame的缘故将导致
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

@end
