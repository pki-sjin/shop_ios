//
//  LoginViewController.h
//  shop
//
//  Created by SHDEVAPPLE001 on 8/27/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic) IBOutlet UITextField* user;
@property (nonatomic) IBOutlet UITextField* password;
@property (nonatomic) IBOutlet UISwitch* remember;

-(IBAction)OK:(id)sender;

-(IBAction)Cancel:(id)sender;

-(IBAction)Done:(id)sender;

@end
