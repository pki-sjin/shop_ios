//
//  GlobalContext.h
//  shop
//
//  Created by SHDEVAPPLE001 on 9/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "BMapKit.h"

@interface GlobalContext : NSObject

+(UserInfo*)GetUserInfo;

+(void)SaveUserInfo:(UserInfo*)info;

+(void)SetUserInfo:(UserInfo*)info;

+(void)ClearUserInfo;

+(bool)UserInfoIsStored;

+(CLLocationCoordinate2D)LastLocation;

+(void)SetLastLocation:(CLLocationCoordinate2D)location;

@end
