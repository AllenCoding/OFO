//
//  LYDataManager.m
//  OFO
//
//  Created by ios on 2017/11/1.
//  Copyright © 2017年 OFO. All rights reserved.
//
//好看的皮囊千篇一律，有趣的灵魂万里挑一

#import "LYDataManager.h"
#import <FMDB.h>
static LYDataManager*_manager;

@interface LYDataManager(){
    FMDatabase*dataBase;
}

@end

@implementation LYDataManager

//只实例化一次
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((self == [super init])) {
            [self openData];
        }
    });
    return self;
}

+(instancetype)shareManager{
    
    return [[self alloc]init];
}

//只分配一次内存
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager==nil) {
            _manager=[super allocWithZone:zone];
        }
    });
    return _manager;
}

-(id)copyWithZone:(NSZone *)zone{
    return _manager;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return _manager;
}


-(void)openData{
    NSString*path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString*dbPath=[path stringByAppendingPathComponent:@"data.db"];
    dataBase=[FMDatabase databaseWithPath:dbPath];
    [dataBase open];
    [self createDatabase];
}

-(void)createDatabase{
    NSString*userSql=@"create table if not exists user(userId integer primary key autoincrement,userPhone text,userNickname text,userHead text,userSex text,userWechat text,userQQ text,userBirthday text,userScore text,userStudent text,userRole text,userAutoPay text,userMessageAlert text,userEnable text,firstLogin text,lastLogin text)";
    BOOL user=[dataBase executeUpdate:userSql];
    if (user) {
        LYLog(@"建表成功");
    }else{
        LYLog(@"建表失败");
    }
}

-(LYUser*)userInfo{
    NSString*selectSql=@"select *from user where userPhone=?";
    FMResultSet *set=[dataBase executeQuery:selectSql,userPhoneNumber];
    LYUser*user=[[LYUser alloc]init];
    while ([set next]) {
        user.userId=[set stringForColumn:@"userId"].integerValue;
        user.userPhone=[set stringForColumn:@"userPhone"];
        user.userNickname=[set stringForColumn:@"userNickname"];
        user.userSex=[set stringForColumn:@"userSex"];
        user.userHead=[set stringForColumn:@"userHead"];
        user.userQQ=[set stringForColumn:@"userQQ"];
        user.userWechat=[set stringForColumn:@"userWechat"];
        user.userRole=[set stringForColumn:@"userRole"];
        user.userScore=[set stringForColumn:@"userScore"];
        user.userAutoPay=[set stringForColumn:@"userAutoPay"];
        user.userStudent=[set stringForColumn:@"userStudent"];
        user.userMessageAlert=[set stringForColumn:@"userMessageAlert"];
        user.userBirthday=[set stringForColumn:@"userBirthday"];
        user.lastLogin=[set stringForColumn:@"lastLogin"];
        user.firstLogin=[set stringForColumn:@"firstLogin"];
        user.userEnable=[set stringForColumn:@"userEnable"];
    }
    return user;
}
-(void)userRegsiter:(LYUser*)user{
    NSString*user_sql=@"insert into user (userPhone,userNickname,userSex,userHead,userQQ,userWechat,userRole,userScore,userAutoPay,userStudent,userMessageAlert,userBirthday,lastLogin,userEnable,firstLogin) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL isOk=[dataBase executeUpdate:user_sql,user.userPhone,user.userNickname,user.userSex,user.userHead,user.userQQ,user.userWechat,user.userRole,user.userScore,user.userAutoPay,user.userStudent,user.userMessageAlert,user.userBirthday,user.lastLogin,user.userEnable,user.firstLogin];
    if (isOk) {
        NSLog(@"用户注册成功");
    }else{
        NSLog(@"用户注册失败");
    }
}

//用户更新信息
-(void)updateUserInfoWithKey:(NSString*)key AndValue:(NSString*)value{
    NSString*psw_update=[NSString stringWithFormat:@"update user set %@= ?where userPhone=?",key];
    BOOL isSS = [dataBase executeUpdate:psw_update,value,userPhoneNumber];
    if (isSS) {
        [NSString stringWithFormat:@"用户%@更新成功",key];
        LYLog(@"%@",[NSString stringWithFormat:@"用户%@更新成功",key]);
    }else{
        LYLog(@"%@",[NSString stringWithFormat:@"用户%@更新失败",key]);
    }
}

-(BOOL)isExistWithPhone:(NSString *)phone{
    //    NSString*selectSql=@"select count(*) as n from user userPhone=?";
    //    FMResultSet *rs=[dataBase executeQuery:selectSql,phone];
    //    NSUInteger count = [dataBase intForQuery:@"select count(*) from user where userPhone=?",phone];
    
    return [dataBase intForQuery:@"select count(*) from user where userPhone=?",phone];
}




@end
