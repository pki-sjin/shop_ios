//
//  ShopWithGeoCell.m
//  shop
//
//  Created by SHDEVAPPLE001 on 11/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "ShopWithGeoCell.h"

@implementation ShopWithGeoCell

@synthesize shopName;

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
