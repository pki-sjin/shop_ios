//
//  RootViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 8/27/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalContext.h"

@interface RootViewController : UITabBarController

@property (nonatomic) IBOutlet UILabel* tips;
@property (nonatomic) IBOutlet UIBarButtonItem* login;

+(RootViewController*)Instance;

-(void)UpdateUserInfo:(UserInfo*)info isIn:(bool)isIn;

-(IBAction)LoginOrOut:(id)sender;

@end
