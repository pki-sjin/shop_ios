//
//  UserInfo.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize position, username, userno, password, sid;

-(bool)isNil
{
    return position == nil || username == nil || userno == nil || password == nil || sid == nil;
}

@end
