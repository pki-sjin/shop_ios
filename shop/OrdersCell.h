//
//  OrdersCell.h
//  shop
//
//  Created by SHDEVAPPLE001 on 9/26/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel* billno;
@property (nonatomic) IBOutlet UILabel* s_store;
@property (nonatomic) IBOutlet UILabel* satisfied;
@property (nonatomic) IBOutlet UILabel* s_date;
@property (nonatomic) IBOutlet UILabel* packagecnt;
@property (nonatomic) IBOutlet UILabel* o_num;
@property (nonatomic) IBOutlet UILabel* a_num;
@property (nonatomic) IBOutlet UILabel* s_num;
@property (nonatomic) IBOutlet UILabel* skucount;
@property (nonatomic) IBOutlet UILabel* remark;

@end
