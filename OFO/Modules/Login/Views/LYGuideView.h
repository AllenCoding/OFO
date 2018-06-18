//
//  LYGuideView.h
//  OFO
//
//  Created by tianqiuqiu on 2017/11/1.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GuideViewBlock)(void);

@interface LYGuideView : UIViewController

@property(nonatomic,strong)NSMutableArray*imagesArray;
@property(nonatomic,copy)GuideViewBlock block;

@end
