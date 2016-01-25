//
//  SecondViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 8/25/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "SheZhiViewController.h"
#import "ShopWithGeoViewController.h"
#import "UserInfo.h"
#import "GlobalContext.h"
#import "RequestTask.h"

@interface SheZhiViewController ()

@end

@implementation SheZhiViewController

NSMutableArray* list;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShowShop:(id)sender
{
    UserInfo* userInfo = [GlobalContext GetUserInfo];
    if (![userInfo isNil])
    {
        list = [RequestTask getStoreWithGeo:userInfo.sid userno:userInfo.userno];
        if (list != nil)
        {
            [self performSegueWithIdentifier:@"ShowShopWithGeo" sender:nil];
        }
    }else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destination = [segue destinationViewController];
    if ([destination isKindOfClass:[ShopWithGeoViewController class]])
    {
        ShopWithGeoViewController* shopWithGeoViewController = (ShopWithGeoViewController*)destination;
        shopWithGeoViewController.list = list;
        shopWithGeoViewController.oringalType = 0;
    }
}

@end
