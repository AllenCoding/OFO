//
//  LYLeftSideView.h
//  OFO
//
//  Created by LiuYong on 2017/10/28.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYLeftSideView;

@protocol LYLeftSideViewDelegate<NSObject>

-(void)LYLeftSideView:(LYLeftSideView*)sideView didFinishSelectAtIndex:(NSInteger)index;

-(void)LYLeftSideView:(LYLeftSideView *)sideView didClickOnClose:(UIButton*)closeBtn;

-(void)LYLeftSideView:(LYLeftSideView *)sideView didClickOnHead:(UIButton*)headBtn;

@end

@interface LYLeftSideView : UIView

@property(nonatomic,weak)id<LYLeftSideViewDelegate>delegate;

-(void)showToWindow;

-(void)hideFromWindow;



@end
