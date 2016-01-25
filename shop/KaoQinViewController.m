//
//  KaoQinViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 11/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "KaoQinViewController.h"
#import "ShopWithGeoViewController.h"
#import "UserInfo.h"
#import "GlobalContext.h"
#import "RequestTask.h"

@interface KaoQinViewController ()

@end

@implementation KaoQinViewController

NSMutableArray* list;

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
    // Do any additional setup after loading the view.
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
            [self performSegueWithIdentifier:@"NeedToSign" sender:nil];
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
        shopWithGeoViewController.oringalType = 1;
    }
}

@end
