//
//  DetailsCell.m
//  shop
//
//  Created by SHDEVAPPLE001 on 10/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "DetailsCell.h"

@implementation DetailsCell

@synthesize plu_no,plu_name,Mainbarcode,plu_style,unit,stan_pack,o_num,a_num,s_num,wh_num;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
