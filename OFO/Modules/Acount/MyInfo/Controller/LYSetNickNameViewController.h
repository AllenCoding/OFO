//
//  LYSetNickNameViewController.h
//  OFO
//
//  Created by LiuYong on 2017/11/2.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYBaseViewController.h"

typedef void(^SetNickNameBlock)(NSString*nickname);

@interface LYSetNickNameViewController : LYBaseViewController

@property(nonatomic,copy)SetNickNameBlock nameBlcok;

@end
