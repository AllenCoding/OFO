//
//  NSString+Addition.h
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)


/**
 根据时间格式返回当前时间

 @param timeformmatter 时间格式
 @return 当前时间字符串
 */
+(NSString*)currentTime:(NSString*)timeformmatter;

/**
 手机校验

 @return <#return value description#>
 */
-(BOOL)isPhone;

/**
 邮箱校验

 @return <#return value description#>
 */
-(BOOL)isEmailWithString:(NSString *)str;




@end
