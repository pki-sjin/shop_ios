//
//  MyLocationViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 10/7/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "MyLocationViewController.h"
#import "GlobalContext.h"

@interface MyLocationViewController ()

@end

@implementation MyLocationViewController

@synthesize locService, mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locService = [[BMKLocationService alloc]init];
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    BMKCoordinateRegion region = BMKCoordinateRegionMake([GlobalContext LastLocation], BMKCoordinateSpanMake(0.005, 0.005));
    [mapView setRegion:region animated:YES];
    self.view = mapView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [mapView viewWillDisappear];
    [GlobalContext SetLastLocation:locService.userLocation.location.coordinate];
    [locService stopUserLocationService];
    mapView.delegate = nil; // 不用时，置nil
    locService.delegate = nil;
}

-(void)myLocation:(id)sender
{
//    mapView.showsUserLocation = NO;//先关闭显示的定位图层
    mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    mapView.showsUserLocation = YES;//显示定位图层
    
//    BMKCoordinateRegion region = BMKCoordinateRegionMake(locService.userLocation.location.coordinate, BMKCoordinateSpanMake(0.005, 0.005));
//    [mapView setRegion:region animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [locService startUserLocationService];
    [self myLocation:nil];
}

- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [mapView updateLocationData:userLocation];
}

@end
