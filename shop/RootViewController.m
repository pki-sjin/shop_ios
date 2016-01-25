//
//  RootViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 8/27/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

@implementation RootViewController

@synthesize tips, login;

static RootViewController* instance;

+(RootViewController *)Instance
{
    return instance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    instance = self;
    UserInfo* info = [GlobalContext GetUserInfo];
    if (![info isNil])
    {
        [self UpdateUserInfo:info isIn: YES];
    }
}

-(void)UpdateUserInfo:(UserInfo *)info isIn:(bool)isIn
{
    if (isIn)
    {
        tips.text = [NSString stringWithFormat:@"%@ %@", info.position, info.username];
        login.title = @"登出";
        login.tag = 1;
    }else
    {
        [GlobalContext ClearUserInfo];
        tips.text = @"你还没有登录";
        login.title = @"登录";
        login.tag = 0;
    }
}

-(void)LoginOrOut:(id)sender
{
    if (login.tag == 0)
    {
        [self performSegueWithIdentifier:@"Login" sender:nil];
    }else
    {
        [self UpdateUserInfo:nil isIn:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
