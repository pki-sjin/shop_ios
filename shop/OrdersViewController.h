//
//  OrdersViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 9/26/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreInfo.h"

@interface OrdersViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic) NSMutableArray* list;
@property (nonatomic) StoreInfo* store;

-(IBAction)refresh:(id)sender;

@end
