//
//  LocationViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 11/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "LocationViewController.h"
#import "RequestTask.h"
#import "GlobalContext.h"
#import "ShopWithGeoViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize storeInfo, requestType;

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
    
    self.title = storeInfo.strname;
    
    if (requestType == 0)
    {
        // 标记
        self.navigationItem.rightBarButtonItem.title = @"标记";
        self.navigationItem.rightBarButtonItem.tag = 0;
    }else
    {
        // 签到
        self.navigationItem.rightBarButtonItem.title = @"签到";
        self.navigationItem.rightBarButtonItem.tag = 1;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:false];
    
    [self InitShopAnnotation];
}

-(void)InitShopAnnotation
{
    double lat = storeInfo.lat.doubleValue;
    double lng = storeInfo.lng.doubleValue;
    
    if (lat != 0 && lng != 0)
    {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = lat;
        coor.longitude = lng;
        annotation.coordinate = coor;
        annotation.title = @"这里是店铺";
        [self.mapView addAnnotation:annotation];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"shop"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    
    return nil;
}

-(void)shopLocation:(id)sender
{
    double lat = storeInfo.lat.doubleValue;
    double lng = storeInfo.lng.doubleValue;
    
    if (lat != 0 && lng != 0)
    {
        self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
        BMKCoordinateRegion region = BMKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lng), BMKCoordinateSpanMake(0.005, 0.005));
        [self.mapView setRegion:region animated:YES];
    }else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"店铺未标记" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)registerOrSign:(id)sender
{
    double lat = storeInfo.lat.doubleValue;
    double lng = storeInfo.lng.doubleValue;
    
    if (self.navigationItem.rightBarButtonItem.tag == 0)
    {
        // 标记
        if (lat != 0 && lng != 0)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"店铺已标记，无法重复标记" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否将当前位置\n纬度：%f\n经度：%f\n设置为店铺位置", self.locService.userLocation.location.coordinate.latitude, self.locService.userLocation.location.coordinate.longitude] delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alert show];
        }
    }else{
        //签到
        if (lat == 0 || lng == 0)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"店铺未标记，无法进行签到" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否将当前位置\n纬度：%f\n经度：%f\n进行签到", self.locService.userLocation.location.coordinate.latitude, self.locService.userLocation.location.coordinate.longitude] delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alert show];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        if (self.navigationItem.rightBarButtonItem.tag == 0)
        {
            // 标记
            bool result = [RequestTask registerStore:[GlobalContext GetUserInfo].sid store:storeInfo.strno lat:self.locService.userLocation.location.coordinate.latitude lng:self.locService.userLocation.location.coordinate.longitude];
            
            if (result)
            {
                storeInfo.lat = [NSString stringWithFormat:@"%f", self.locService.userLocation.location.coordinate.latitude];
                storeInfo.lng = [NSString stringWithFormat:@"%f", self.locService.userLocation.location.coordinate.longitude];
                
                [self InitShopAnnotation];
                
                int index = [self.navigationController.viewControllers indexOfObject:self.navigationController.topViewController];
                id previousViewController = [self.navigationController.viewControllers objectAtIndex:index - 1];
                
                ShopWithGeoViewController* shopViewController = (ShopWithGeoViewController*)previousViewController;
                
                shopViewController.needToRefresh = true;
            }
        }else
        {
            // 签到
            [RequestTask signInAndOut:[GlobalContext GetUserInfo].sid userno:[GlobalContext GetUserInfo].userno store:storeInfo.strno lat:self.locService.userLocation.location.coordinate.latitude lng:self.locService.userLocation.location.coordinate.longitude];
        }
    }
}

@end
