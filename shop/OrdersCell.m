//
//  OrdersCell.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/26/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "OrdersCell.h"

@implementation OrdersCell

@synthesize billno, s_store, s_date, satisfied, packagecnt, o_num, a_num, s_num, skucount, remark;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
