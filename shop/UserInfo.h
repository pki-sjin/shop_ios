//
//  UserInfo.h
//  shop
//
//  Created by SHDEVAPPLE001 on 9/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic) NSString* position;
@property (nonatomic) NSString* username;
@property (nonatomic) NSString* userno;
@property (nonatomic) NSString* password;
@property (nonatomic) NSString* sid;

-(bool)isNil;

@end
