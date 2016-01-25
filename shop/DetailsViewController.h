//
//  DetailsViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 10/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreInfo.h"
#import "OrderInfo.h"

@interface DetailsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray* list;
@property (nonatomic) StoreInfo* store;
@property (nonatomic) OrderInfo* order;

-(IBAction)refresh:(id)sender;

@end
