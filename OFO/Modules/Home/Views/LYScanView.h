//
//  LYScanView.h
//  OFO
//
//  Created by LiuYong on 2017/10/28.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanViewDelegate<NSObject>
@required


/**
 点击我的信息
 */
-(void)didSelectAccountAction;
/**
 点击我的消息
 */
-(void)didSelectMessageAction;
/**
 点击扫描按钮
 */
-(void)didClickScanAction;
/**
 判断是否隐藏

 @param isHide 是否隐藏
 */
-(void)scanViewIsHide:(BOOL)isHide;

/**
 判断是否有动画

 @param animated 是否手势
 */
-(void)scanViewAnimation:(BOOL)animated;

@end

@interface LYScanView : UIView

@property(nonatomic,weak)id<ScanViewDelegate>delegate;


@end
