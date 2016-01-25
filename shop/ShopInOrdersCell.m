//
//  ShopInOrdersCell.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/20/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "ShopInOrdersCell.h"

@implementation ShopInOrdersCell

@synthesize shopName, num;

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
