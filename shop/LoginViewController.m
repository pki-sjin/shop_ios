//
//  LoginViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 8/27/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import "GlobalContext.h"
#import "RequestTask.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize user, password, remember;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)OK:(id)sender
{
    [self HideKeyBoard];
    
    if ([user.text  isEqual: @""] || [password.text  isEqual: @""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else
    {
        UserInfo* userInfo = [RequestTask Login:user.text password:password.text];
        if (userInfo != nil)
        {
            if ([remember isOn])
            {
                [GlobalContext SaveUserInfo:userInfo];
            }else
            {
                [GlobalContext SetUserInfo:userInfo];
            }
            
            [[RootViewController Instance] UpdateUserInfo:userInfo isIn:YES];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)BlockUI:(bool)isBlock
{
    [self.view setUserInteractionEnabled:!isBlock];
    [[[self navigationController] navigationBar] setUserInteractionEnabled:!isBlock];
}

-(void)Cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)Done:(id)sender
{
    [sender resignFirstResponder];
}

-(void)HideKeyBoard
{
    [user resignFirstResponder];
    [password resignFirstResponder];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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
