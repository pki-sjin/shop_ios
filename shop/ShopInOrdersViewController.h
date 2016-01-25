//
//  ShopInOrdersViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 9/20/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInOrdersViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray* list;
@property (nonatomic) bool needToRefresh;

-(IBAction)refresh:(id)sender;

@end
