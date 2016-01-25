//
//  MyLocationViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 10/7/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface MyLocationViewController : UIViewController <BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, assign) BMKMapView* mapView;

@property (nonatomic, assign) BMKLocationService* locService;

-(IBAction)myLocation:(id)sender;

@end
