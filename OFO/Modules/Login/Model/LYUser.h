//
//  LYUser.h
//  OFO
//
//  Created by ios on 2017/11/1.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUser : NSObject

@property(nonatomic,assign)NSInteger userId;//人员编号
@property(nonatomic,copy)NSString*userPhone;//手机
@property(nonatomic,copy)NSString*userNickname;//昵称
@property(nonatomic,copy)NSString*userHead;//头像
@property(nonatomic,copy)NSString*userSex;//性别
@property(nonatomic,copy)NSString*userWechat;//微信
@property(nonatomic,copy)NSString*userQQ;//QQ
@property(nonatomic,copy)NSString*userBirthday;//生日
@property(nonatomic,copy)NSString*userScore;//积分
@property(nonatomic,copy)NSString*userStudent;//校园
@property(nonatomic,copy)NSString*userRole;//ofo身份
@property(nonatomic,copy)NSString*userAutoPay;//自动付款
@property(nonatomic,copy)NSString*userMessageAlert;//消息提醒
@property(nonatomic,copy)NSString*userEnable;//权限设置
@property(nonatomic,copy)NSString*firstLogin;//第一次登陆时间
@property(nonatomic,copy)NSString*lastLogin;//最后一次登陆时间


@end
