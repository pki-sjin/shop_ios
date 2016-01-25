//
//  LocationViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 11/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLocationViewController.h"
#import "StoreInfo.h"

@interface LocationViewController : MyLocationViewController <UIAlertViewDelegate>

@property (nonatomic) StoreInfo* storeInfo;

@property (nonatomic) int requestType;

-(IBAction)shopLocation:(id)sender;

-(IBAction)registerOrSign:(id)sender;

@end
