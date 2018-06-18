//
//  NSString+Addition.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

+(NSString*)currentTime:(NSString*)timeformmatter{
    
    NSDate*date=[NSDate date];
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:timeformmatter];
    NSString*dateString=[formatter stringFromDate:date];
   
    return dateString;
}

//是否是手机号
-(BOOL)isPhone{
    return [self match:@"^1[3578]\\d{9}$"];
    
}
- (BOOL)match:(NSString *)pattern { //创建正则表达式
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

/**
 *  邮箱地址是否合法
 */
-(BOOL)isEmailWithString:(NSString *)str{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}







@end
