//
//  DingDanViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/20/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "DingDanViewController.h"
#import "RequestTask.h"
#import "GlobalContext.h"
#import "UserInfo.h"
#import "ShopInOrdersViewController.h"

@interface DingDanViewController ()

@end

@implementation DingDanViewController

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
    [self.tabBarItem setBadgeValue:nil];
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
        list = [RequestTask getStore:userInfo.sid userno:userInfo.userno];
        if (list != nil)
        {
            [self performSegueWithIdentifier:@"ShowShopInOrders" sender:nil];
        }
    }else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShopInOrdersViewController* destination = [segue destinationViewController];
    destination.list = list;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
