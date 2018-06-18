//
//  LYDataManager.h
//  OFO
//
//  Created by ios on 2017/11/1.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYUser.h"

@interface LYDataManager : NSObject

/**
 初始化单例类
 */
+(instancetype)shareManager;

#pragma mark 用户信息管理

-(LYUser*)userInfo;

-(BOOL)isExistWithPhone:(NSString*)phone;

-(void)userRegsiter:(LYUser*)user;

-(void)updateUserInfoWithKey:(NSString*)key AndValue:(NSString*)value;





@end
