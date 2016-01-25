//
//  RequestTask.h
//  shop
//
//  Created by SHDEVAPPLE001 on 9/24/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "StoreInfo.h"
#import "OrderInfo.h"
#import "DetailInfo.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "GlobalContext.h"

@interface RequestTask : NSObject

+(UserInfo*)Login:(NSString*)username password:(NSString*)password;

+(NSMutableArray*)getStore:(NSString*)sid userno:(NSString*)userno;

+(NSMutableArray*)getBill:(NSString*)sid store:(StoreInfo*)store;

+(NSMutableArray*)getBillDetail:(NSString*)sid store:(StoreInfo*)store bill:(OrderInfo*)order;

+(bool)dealBillByStr:(NSString*)sid dealType:(int)dealType store:(StoreInfo*)store bill:(OrderInfo*)order;

+(NSMutableArray*)getStoreWithGeo:(NSString*)sid userno:(NSString*)userno;

+(bool)registerStore:(NSString*)sid store:(NSString*)strno lat:(double)lat lng:(double)lng;

+(bool)signInAndOut:(NSString*)sid userno:(NSString*)userno store:(NSString*)strno lat:(double)lat lng:(double)lng;

@end
