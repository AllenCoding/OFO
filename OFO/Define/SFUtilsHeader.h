//
//  SFUtilsHeader.h
//  ShareFit
//
//  Created by YNTS on 2017/9/28.
//  Copyright © 2017年 YNTS. All rights reserved.
//

#ifndef SFUtilsHeader_h
#define SFUtilsHeader_h

/*打印输出*/
#define LYLog(format, ...) NSLog((@"方法=%s 行数=%d\n打印结果=" format),__PRETTY_FUNCTION__,__LINE__, ##__VA_ARGS__);
/*获取APP版本*/
#define APP_SHORTVERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/*获取APP标识*/
#define APP_IDENTIFIER [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
/*获取手机版本*/
#define SYS_VERSION [[UIDevice currentDevice] systemVersion]
#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS9_OR_EARLIER (!IOS10_OR_LATER)
#define IOS8_OR_EARLIER (!IOS9_OR_LATER)
#define IOS7_OR_EARLIER (!IOS8_OR_LATER)
#define IOS6_OR_EARLIER (!IOS7_OR_LATER)

/*手机型号iphoneX*/
#define iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
#define IPHONE_4_4S  [@(ScreenHeight) compare:@(480)] == NSOrderedSame
#define IPHONE_5_5S  [@(ScreenHeight) compare:@(568)] == NSOrderedSame
#define IPHONE_6P_6PS [@(ScreenHeight) compare:@(736)] == NSOrderedSame
#define IPHONE_6_6S  [@(ScreenHeight) compare:@(667)] == NSOrderedSame

/*用户登录信息*/
#define isNetReachable [[NSUserDefaults standardUserDefaults]boolForKey:@"NetWorkReachable"]
#define isLogin [[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"]
#define userPhoneNumber  [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"]
#define isFirstInstall [[NSUserDefaults standardUserDefaults]boolForKey:@"isFirstInstall"]


#define userNickName  [[NSUserDefaults standardUserDefaults]objectForKey:@"nickname"]
#define usersid  [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]
#define userHx_pass  [[NSUserDefaults standardUserDefaults]objectForKey:@"hx_pass"]
#define serviceCall  [[NSUserDefaults standardUserDefaults]objectForKey:@"serviceCall"]
#define userLatitude [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"]
#define userLongitude [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"]
#define protocal_url [[NSUserDefaults standardUserDefaults]objectForKey:@"protocolUrl"]
#define isRemind  [[NSUserDefaults standardUserDefaults]boolForKey:@"isRemind"]





/*高德地图---极光---环信*/
#define AMapKitApiKey  @"2ec07fd5ae0a9df1d14ce77507e50adc"

/*其他信息*/
#define USER_INFO_SERVER_NAME @"DeviceUUID"
#define UUID_KEY @"UUID_Key"


#pragma mark ---通知
#define LocationUpdateSucceedNotification @"LocationUpdateSucceedNotification"
#define LoginSuccessNotification @"LoginSuccessNotification"
#define LogoutSuccessNotification @"LogoutSuccessNotification"
#define NetworkSuccessNotification @"NetworkSuccessNotification"
#define NetworkFailureNotification @"NetworkFailureNotification"
#define LocationSuccessNotification @"LocationSuccessNotification"
#define LocationFailureNotification @"LocationFailureNotification"
#define CodeSuccessNotification @"CodeSuccessNotification"

#define PaySuccessNotification @"PaySuccessNotification"
#define PayFailureNotification @"PayFailureNotification"


#define ResetPhoneSuccessNotification @"ResetPhoneSuccessNotification"





#pragma mark 支付配置信息
#define Alipay_PID @""
#define Alipay_seller @""
#define Alipay_appScheme @"AlipayShareFitScheme"
#define Alipay_privateKey @""

#define WeChatAppID @"wxc2681d4e34de712b"
#define WeChatAppSecret @""
#define WeChatPrivateKey @""
#define WeChatShopID @""


#endif /* SFUtilsHeader_h */
