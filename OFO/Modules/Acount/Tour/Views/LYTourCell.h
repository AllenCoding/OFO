//
//  LYTourCell.h
//  OFO
//
//  Created by tianqiuqiu on 2017/11/8.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTour.h"

@interface LYTourCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *costLabel;
@property(nonatomic,strong)LYTour*tour;

+(instancetype)initCellWithTableview:(UITableView*)tableview;

@end
