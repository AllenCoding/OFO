//
//  LYCustomAlertView.h
//  OFO
//
//  Created by tianqiuqiu on 2017/11/3.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LYCustomAlertView;

typedef NS_ENUM(NSInteger, LYCustomAlertViewStyle) {
    LYCustomAlertViewDefaultStyle,
    LYCustomAlertViewDateAlertStyle,//默认从0开始

};


@protocol LYCustomAlertViewDelegate<NSObject>

-(void)LYCustomAlertView:(LYCustomAlertView*)alertView didSelectAlertResult:(NSString*)result;

@end

@interface LYCustomAlertView : UIViewController

@property(nonatomic,weak)id<LYCustomAlertViewDelegate>delegate;
@property(nonatomic,assign)LYCustomAlertViewStyle style;
@property(nonatomic,strong)NSMutableArray*dataSource;



@end
