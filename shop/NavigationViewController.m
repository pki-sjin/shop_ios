//
//  NavigationViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 8/27/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "NavigationViewController.h"
#import "OrdersViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationBar] setBarTintColor:[UIColor colorWithRed:0 green:255 blue:0 alpha:255]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
