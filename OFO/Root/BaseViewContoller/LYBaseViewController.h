//
//  LYBaseViewController.h
//  OFO
//
//  Created by tianqiuqiu on 2017/10/27.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   导航栏左右按钮的方向
 - NavgationBarItemLeftDirection: 方向
   */
typedef NS_ENUM(NSInteger, NavgationBarItemDirection) {
    NavgationBarItemLeftDirection,//默认从0开始
    NavgationBarItemRightDirection,
};

@interface LYBaseViewController : UIViewController
/**
 快速创建导航栏左右按钮
 
 @param title 标题
 @param color 标题颜色
 @param font 标题字体大小
 @param action 事件
 @param direction 方向
 
 */
-(void)setNavgationBarItemWithTitle:(NSString*)title titleColor:(UIColor*)color Font:(UIFont*)font WithSelector:(SEL)action direction:(NavgationBarItemDirection)direction;

/**
 快速创建导航栏图片按钮

 @param imageName 图片名称
 @param action 点击事件
 @param direction 方向
 */
-(void)setNavgationBarItemWithImageName:(NSString*)imageName  WithSelector:(SEL)action direction:(NavgationBarItemDirection)direction;


@end
