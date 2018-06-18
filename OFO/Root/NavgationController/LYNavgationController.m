//
//  LYNavgationController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/27.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYNavgationController.h"

@interface LYNavgationController ()

@end

@implementation LYNavgationController


+ (void)initialize {
    // 设置为不透明
    [[UINavigationBar appearance] setTranslucent:NO];//这个属性 包含导航栏（0，0）开始 （0.64）开始
    // 设置导航栏背景颜色
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    // 创建字典保存文字大小和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSFontAttributeName] = BoldFontWithSize(16);
    color[NSForegroundColorAttributeName] = ColorWithRGB(55, 56, 55);
    [[UINavigationBar appearance] setTitleTextAttributes:color];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    // 拿到整个导航控制器的外观
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    item.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    // 设置字典的字体大小
    NSMutableDictionary * atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = BoldFontWithSize(16);
    atts[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 将字典给item
    [item setTitleTextAttributes:atts forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /**
     *  如果在堆栈控制器数量大于1 加返回按钮
     */
    if (self.viewControllers.count > 0) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Nav_back"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        btn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        viewController.hidesBottomBarWhenPushed = YES;
              
    }
    
    [super pushViewController:viewController animated:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
