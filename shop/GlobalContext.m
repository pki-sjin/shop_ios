//
//  GlobalContext.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "GlobalContext.h"

@implementation GlobalContext

static UserInfo* currentUserInfo;

+(UserInfo*)GetUserInfo
{
    if (currentUserInfo == nil)
    {
        NSString* position = [[NSUserDefaults standardUserDefaults] objectForKey:@"position"];
        NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        NSString* userno = [[NSUserDefaults standardUserDefaults] objectForKey:@"userno"];
        NSString* password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        NSString* sid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sid"];
        
        UserInfo* userInfo = [[UserInfo alloc] init];
        userInfo.position = position;
        userInfo.userno = userno;
        userInfo.username = username;
        userInfo.password = password;
        userInfo.sid = sid;
        currentUserInfo = userInfo;
    }
    
    return currentUserInfo;
}

+(void)ClearUserInfo
{
    currentUserInfo = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"position"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userno"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sid"];
}

+(void)SaveUserInfo:(UserInfo*)info
{
    currentUserInfo = info;
    [[NSUserDefaults standardUserDefaults] setObject:info.position forKey:@"position"];
    [[NSUserDefaults standardUserDefaults] setObject:info.username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:info.userno forKey:@"userno"];
    [[NSUserDefaults standardUserDefaults] setObject:info.password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:info.sid forKey:@"sid"];
}

+(void)SetUserInfo:(UserInfo *)info
{
    currentUserInfo = info;
}

+(bool)UserInfoIsStored
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sid"] != nil;
}

+(CLLocationCoordinate2D)LastLocation
{
    double lat = [[NSUserDefaults standardUserDefaults] doubleForKey:@"lat"];
    double lng = [[NSUserDefaults standardUserDefaults] doubleForKey:@"lng"];
    return CLLocationCoordinate2DMake(lat, lng);
}

+(void)SetLastLocation:(CLLocationCoordinate2D)location
{
    [[NSUserDefaults standardUserDefaults] setDouble:location.latitude forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults] setDouble:location.longitude forKey:@"lng"];
}

@end
