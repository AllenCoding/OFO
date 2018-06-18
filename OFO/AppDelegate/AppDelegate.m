//
//  AppDelegate.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/27.
//  Copyright © 2017年 OFO. All rights reserved.

#import "AppDelegate.h"
#import "LYNavgationController.h"
#import "LYHomeViewController.h"
#import "LYMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    LYHomeViewController*homeVc=[[LYHomeViewController alloc]init];
    LYMainViewController*mainVc=[[LYMainViewController alloc]init];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LYNavgationController*nav=[[LYNavgationController alloc]initWithRootViewController:isLogin?homeVc:mainVc];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    [AMapServices sharedServices].apiKey = AMapKitApiKey;
    
    LYLog(@"%@",NSHomeDirectory());
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
