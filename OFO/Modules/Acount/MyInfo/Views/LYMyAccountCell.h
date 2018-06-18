//
//  LYMyAccountCell.h
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYMyAccountCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;

+(instancetype)configCellWithTableView:(UITableView*)tableview;

@end
