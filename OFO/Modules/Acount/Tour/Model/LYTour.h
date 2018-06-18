//
//  LYTour.h
//  OFO
//
//  Created by tianqiuqiu on 2017/11/8.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTour : NSObject

@property(nonatomic,assign)NSInteger tourId;
@property(nonatomic,copy)NSString*tourUser;
@property(nonatomic,copy)NSString*tourStartTime;
@property(nonatomic,copy)NSString*tourEndTime;
@property(nonatomic,strong)LYLoction*tourStartLocation;
@property(nonatomic,strong)LYLoction*tourEndLocation;
@property(nonatomic,copy)NSString*tourFee;
@property(nonatomic,copy)NSString*tourBikeNumber;

@end
