//
//  LYTourCell.m
//  OFO
//
//  Created by tianqiuqiu on 2017/11/8.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYTourCell.h"

@implementation LYTourCell

+(instancetype)initCellWithTableview:(UITableView *)tableview{
    NSString*identifer=@"LYTourCell";
    LYTourCell*cell=[tableview dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"LYTourCell" owner:self options:nil].lastObject;
    }
    return cell;
    
}

-(void)setTour:(LYTour *)tour{
    self.timeLabel.text=tour.tourStartTime;
    self.costLabel.text=[NSString stringWithFormat:@"车牌号%@ | 花费%@",tour.tourBikeNumber,tour.tourFee];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
