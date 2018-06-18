//
//  LYMyAccountCell.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYMyAccountCell.h"

@implementation LYMyAccountCell

+(instancetype)configCellWithTableView:(UITableView*)tableview{
    static NSString*identifer=@"LYMyAccountCell";
    LYMyAccountCell*cell=[tableview dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"LYMyAccountCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
