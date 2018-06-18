//
//  SFSizeHeader.h
//  ShareFit
//
//  Created by YNTS on 2017/9/28.
//  Copyright © 2017年 YNTS. All rights reserved.
//

#ifndef SFSizeHeader_h
#define SFSizeHeader_h

#pragma mark -屏幕宽高

#define Screenwidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define TabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define NavgationBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

#define NormalRowHeight         44.0f
#define RowHeightA              50.0f

#define DefaultDetailLineSpace  8.0f
#define BackgroudLineWH         0.5f

#define lowerMargin 6.0f
#define bigerMargin 15.0f
#define normarMargin20 20.0f
#define normalMargin11 11.0f
#define greatMargin27 27.0f
#define quHaoLableW 84.0f
#define margin67 67.0f
#define margin17 17.0f
#define margin13 13.0f
#define margin12 12.0f
#define margin8 8.0f
#define margin7 7.0f
#define margin10 10.0f
#define margin30 30.0f
#define margin35 35.0f
#define cellHeightA 73.0f
#define headImgH (Screenwidth*253/414.0)
#define margin3 3.0f
#define margin5 5.0f

// 6p尺寸比例
#define k6pToScaleW Screenwidth / 414.0f
#define k6pToScaleH ScreenHeight / 672.0f

#endif /* SFSizeHeader_h */
