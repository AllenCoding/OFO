//
//  LYCodeView.h
//  OFO
//
//  Created by LiuYong on 2017/10/29.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYCodeView;

@protocol LYCodeViewDelegate<NSObject>

@required

-(void)CodeView:(LYCodeView*)codeView didSelectAtIndex:(NSInteger)index;

@end

@interface LYCodeView : UIView

@property(nonatomic,strong)NSString*bikeCode;

@property(nonatomic,weak)id<LYCodeViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame AndCodesArray:(NSMutableArray*)arr;

-(void)hide;


@end





