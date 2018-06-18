//
//  LYBaseViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/27.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYBaseViewController.h"

@interface LYBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LYBaseViewController

-(void)setNavgationBarItemWithImageName:(NSString *)imageName WithSelector:(SEL)action direction:(NavgationBarItemDirection)direction{
    if (!imageName) {
        return;
    }else{
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 0, 20, 20);
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*Item=[[UIBarButtonItem alloc]initWithCustomView:button];
        if (direction==0) {
            self.navigationItem.leftBarButtonItem=Item;
        }else{
            self.navigationItem.rightBarButtonItem=Item;
        }
    }
}

-(void)setNavgationBarItemWithTitle:(NSString *)title titleColor:(UIColor*)color Font:(UIFont*)font WithSelector:(SEL)action direction:(NavgationBarItemDirection)direction{
    if (!title) {
        return;
    }else{
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 0, 40, 30);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateSelected];
        [button setTitleColor:color forState:UIControlStateNormal];
        button.titleLabel.font=font;
        button.titleLabel.textAlignment=1;
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*Item=[[UIBarButtonItem alloc]initWithCustomView:button];
        if (direction==0) {
            self.navigationItem.leftBarButtonItem=Item;
        }else{
            self.navigationItem.rightBarButtonItem=Item;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //只有在二级页面生效
        if ([self.navigationController.viewControllers count] >1) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
 }



/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
