//
//  UINavigationController+rotate.m
//  shop
//
//  Created by SHDEVAPPLE001 on 10/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "UINavigationController+rotate.h"

@implementation UINavigationController (rotate)

-(NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
