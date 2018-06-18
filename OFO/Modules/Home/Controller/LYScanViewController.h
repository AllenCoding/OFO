//
//  LYScanViewController.h
//  OFO
//
//  Created by LiuYong on 2017/10/28.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AutoReturnBlock)(void);
typedef void(^ReturnCodeBlock)(NSArray*codes,NSString*bikeCode);

@interface LYScanViewController : UIViewController

@property(nonatomic,copy)AutoReturnBlock returnBlock;
@property(nonatomic,copy)ReturnCodeBlock codeBlock;

@end
