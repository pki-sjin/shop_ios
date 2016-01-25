//
//  ShopWithGeoViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 11/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopWithGeoViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray* list;
@property (nonatomic) bool needToRefresh;
@property (nonatomic) int oringalType;

-(IBAction)refresh:(id)sender;

@end
