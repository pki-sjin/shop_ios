//
//  RequestTask.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/24/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "RequestTask.h"

@implementation RequestTask

static NSString* urlStr = @"http://218.83.243.78:8090/WebService.asmx";

static NSString* host = @"218.83.243.78:8090";

const int TIMEOUT = 5;

static ASIHTTPRequest* request;

+(UserInfo*)Login:(NSString*)username password:(NSString*)password
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/Login\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><Login xmlns=\"http://tempuri.org/\"><username>%@</username><password>%@</password></Login></S:Body></S:Envelope>",username, password];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return  nil;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<LoginResult>"];
    NSRange end = [result rangeOfString:@"</LoginResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    NSDictionary* json = [s JSONValue];
    
    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        NSString* message = [json objectForKey:@"message"];
        [self ShowDialog:message];
        return nil;
    }else
    {
        UserInfo* info = [[UserInfo alloc] init];
        info.position = [json objectForKey:@"position"];
        info.username = [json objectForKey:@"username"];
        info.userno = [json objectForKey:@"userno"];
        info.password = password;
        info.sid = [json objectForKey:@"sid"];
        return info;
    }
}

+(NSMutableArray*)getStore:(NSString *)sid userno:(NSString *)userno
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/getStoreInfo\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><getStoreInfo xmlns=\"http://tempuri.org/\"><sid>%@</sid><username>%@</username></getStoreInfo></S:Body></S:Envelope>",sid, userno];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return nil;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<getStoreInfoResult>"];
    NSRange end = [result rangeOfString:@"</getStoreInfoResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    id json = [s JSONValue];
    if ([json isKindOfClass:[NSDictionary class]]) {
        json = (NSDictionary*)json;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSString* jsonStr = [NSString stringWithFormat:@"{\"list\":%@}", s];
        json = [jsonStr JSONValue];
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return nil;
    }
    
    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        if ([status isEqualToString:@"2"]) {
            UserInfo* userInfo = [self Login:[GlobalContext GetUserInfo].userno password:[GlobalContext GetUserInfo].password];
            if (![userInfo isNil])
            {
                if ([GlobalContext UserInfoIsStored])
                {
                    [GlobalContext SaveUserInfo:userInfo];
                }else
                {
                    [GlobalContext SetUserInfo:userInfo];
                }
                
                return [self getStore:userInfo.sid userno:userInfo.userno];
            }else
            {
                return nil;
            }
        }else
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return nil;
        }
    }else
    {
        NSMutableArray* list = [[NSMutableArray alloc] init];
        NSArray* array = [json objectForKey:@"list"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary* obj = [array objectAtIndex:i];
            StoreInfo* storeInfo = [[StoreInfo alloc] init];
            storeInfo.billcount = [NSString stringWithFormat:@"%@", [obj objectForKey:@"billcount"]];
            storeInfo.straddress = [NSString stringWithFormat:@"%@", [obj objectForKey:@"straddress"]];
            storeInfo.strname = [NSString stringWithFormat:@"%@", [obj objectForKey:@"strname"]];
            storeInfo.strno = [NSString stringWithFormat:@"%@", [obj objectForKey:@"strno"]];
            [list addObject:storeInfo];
        }
        
        return list;
    }
}

+(NSMutableArray*)getStoreWithGeo:(NSString *)sid userno:(NSString *)userno
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/getAllStoreInfo\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><getAllStoreInfo xmlns=\"http://tempuri.org/\"><sid>%@</sid><userno>%@</userno></getAllStoreInfo></S:Body></S:Envelope>",sid, userno];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return nil;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<getAllStoreInfoResult>"];
    NSRange end = [result rangeOfString:@"</getAllStoreInfoResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    id json = [s JSONValue];
    if ([json isKindOfClass:[NSDictionary class]]) {
        json = (NSDictionary*)json;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSString* jsonStr = [NSString stringWithFormat:@"{\"list\":%@}", s];
        json = [jsonStr JSONValue];
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return nil;
    }
    
    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        if ([status isEqualToString:@"2"]) {
            UserInfo* userInfo = [self Login:[GlobalContext GetUserInfo].userno password:[GlobalContext GetUserInfo].password];
            if (![userInfo isNil])
            {
                if ([GlobalContext UserInfoIsStored])
                {
                    [GlobalContext SaveUserInfo:userInfo];
                }else
                {
                    [GlobalContext SetUserInfo:userInfo];
                }
                
                return [self getStoreWithGeo:userInfo.sid userno:userInfo.userno];
            }else
            {
                return nil;
            }
        }else
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return nil;
        }
    }else
    {
        NSMutableArray* list = [[NSMutableArray alloc] init];
        NSArray* array = [json objectForKey:@"list"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary* obj = [array objectAtIndex:i];
            StoreInfo* storeInfo = [[StoreInfo alloc] init];
            storeInfo.straddress = [NSString stringWithFormat:@"%@", [obj objectForKey:@"straddress"]];
            storeInfo.strname = [NSString stringWithFormat:@"%@", [obj objectForKey:@"strname"]];
            storeInfo.strno = [NSString stringWithFormat:@"%@", [obj objectForKey:@"strno"]];
            storeInfo.lat = [NSString stringWithFormat:@"%@", [obj objectForKey:@"lat"]];
            storeInfo.lng = [NSString stringWithFormat:@"%@", [obj objectForKey:@"lng"]];
            [list addObject:storeInfo];
        }
        
        return list;
    }
}

+(NSMutableArray *)getBill:(NSString *)sid store:(StoreInfo *)store
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/getBillInfo\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><getBillInfo xmlns=\"http://tempuri.org/\"><sid>%@</sid><strno>%@</strno></getBillInfo></S:Body></S:Envelope>",sid, store.strno];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return nil;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<getBillInfoResult>"];
    NSRange end = [result rangeOfString:@"</getBillInfoResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    id json = [s JSONValue];
    if ([json isKindOfClass:[NSDictionary class]]) {
        json = (NSDictionary*)json;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSString* jsonStr = [NSString stringWithFormat:@"{\"list\":%@}", s];
        json = [jsonStr JSONValue];
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return nil;
    }
    
    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        if ([status isEqualToString:@"2"]) {
            UserInfo* userInfo = [self Login:[GlobalContext GetUserInfo].userno password:[GlobalContext GetUserInfo].password];
            if (![userInfo isNil])
            {
                if ([GlobalContext UserInfoIsStored])
                {
                    [GlobalContext SaveUserInfo:userInfo];
                }else
                {
                    [GlobalContext SetUserInfo:userInfo];
                }
                
                return [self getBill:userInfo.sid store:store];
            }else
            {
                return nil;
            }
        }else
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return nil;
        }
    }else
    {
        NSMutableArray* list = [[NSMutableArray alloc] init];
        NSArray* array = [json objectForKey:@"list"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary* obj = [array objectAtIndex:i];
            OrderInfo* orderInfo = [[OrderInfo alloc] init];
            orderInfo.billno = [NSString stringWithFormat:@"%@", [obj objectForKey:@"billno"]];
            orderInfo.s_store = [NSString stringWithFormat:@"%@", [obj objectForKey:@"s_store"]];
            orderInfo.s_date = [NSString stringWithFormat:@"%@", [obj objectForKey:@"s_date"]];
            orderInfo.packagecnt = [NSString stringWithFormat:@"%@", [obj objectForKey:@"packagecnt"]];
            orderInfo.o_num = [NSString stringWithFormat:@"%@", [obj objectForKey:@"o_num"]];
            orderInfo.a_num = [NSString stringWithFormat:@"%@", [obj objectForKey:@"a_num"]];
            orderInfo.s_num = [NSString stringWithFormat:@"%@", [obj objectForKey:@"s_num"]];
            orderInfo.skucount = [NSString stringWithFormat:@"%@", [obj objectForKey:@"skucount"]];
            orderInfo.remark = [NSString stringWithFormat:@"%@", [obj objectForKey:@"remark"]];
            [list addObject:orderInfo];
        }
        
        return list;
    }
}

+(NSMutableArray *)getBillDetail:(NSString *)sid store:(StoreInfo *)store bill:(OrderInfo *)order
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/getBillDetail\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><getBillDetail xmlns=\"http://tempuri.org/\"><sid>%@</sid><strno>%@</strno><billno>%@</billno></getBillDetail></S:Body></S:Envelope>",sid, store.strno, order.billno];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return nil;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<getBillDetailResult>"];
    NSRange end = [result rangeOfString:@"</getBillDetailResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    id json = [s JSONValue];
    if ([json isKindOfClass:[NSDictionary class]]) {
        json = (NSDictionary*)json;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSString* jsonStr = [NSString stringWithFormat:@"{\"list\":%@}", s];
        json = [jsonStr JSONValue];
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return nil;
    }
    
    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        if ([status isEqualToString:@"2"]) {
            UserInfo* userInfo = [self Login:[GlobalContext GetUserInfo].userno password:[GlobalContext GetUserInfo].password];
            if (![userInfo isNil])
            {
                if ([GlobalContext UserInfoIsStored])
                {
                    [GlobalContext SaveUserInfo:userInfo];
                }else
                {
                    [GlobalContext SetUserInfo:userInfo];
                }
                
                return [self getBillDetail:userInfo.sid store:store bill:order];
            }else
            {
                return nil;
            }
        }else
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return nil;
        }
    }else
    {
        NSMutableArray* list = [[NSMutableArray alloc] init];
        NSArray* array = [json objectForKey:@"list"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary* obj = [array objectAtIndex:i];
            DetailInfo* detailInfo = [[DetailInfo alloc] init];
            detailInfo.plu_no = [NSString stringWithFormat:@"%@", [obj objectForKey:@"plu_no"]];
            detailInfo.plu_name = [NSString stringWithFormat:@"%@", [obj objectForKey:@"plu_name"]];
            detailInfo.Mainbarcode = [NSString stringWithFormat:@"%@", [obj objectForKey:@"Mainbarcode"]];
            detailInfo.plu_style = [NSString stringWithFormat:@"%@", [obj objectForKey:@"plu_style"]];
            detailInfo.unit = [NSString stringWithFormat:@"%@", [obj objectForKey:@"unit"]];
            detailInfo.stan_pack = [NSString stringWithFormat:@"%@", [obj objectForKey:@"stan_pack"]];
            detailInfo.o_num = [NSString stringWithFormat:@"%@", [obj objectForKey:@"o_num"]];
            detailInfo.a_num = [NSString stringWithFormat:@"%@", [obj objectForKey:@"a_num"]];
            detailInfo.s_num = [NSString stringWithFormat:@"%@", [obj objectForKey:@"s_num"]];
            detailInfo.wh_num = [NSString stringWithFormat:@"%@", [obj objectForKey:@"wh_num"]];
            
            [list addObject:detailInfo];
        }
        
        return list;
    }
}


+(bool)dealBillByStr:(NSString *)sid dealType:(int)dealType store:(StoreInfo *)store bill:(OrderInfo *)order
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/dealBillByStr\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><dealBillByStr xmlns=\"http://tempuri.org/\"><sid>%@</sid><dealtype>%d</dealtype><strno>%@</strno><billno>%@</billno></dealBillByStr></S:Body></S:Envelope>",sid, dealType ,store.strno, order.billno];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return NO;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<dealBillByStrResult>"];
    NSRange end = [result rangeOfString:@"</dealBillByStrResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    id json = [s JSONValue];
    if ([json isKindOfClass:[NSDictionary class]]) {
        json = (NSDictionary*)json;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSString* jsonStr = [NSString stringWithFormat:@"{\"list\":%@}", s];
        json = [jsonStr JSONValue];
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return NO;
    }

    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        if ([status isEqualToString:@"5"])
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return YES;
        }else if ([status isEqualToString:@"2"])
        {
            UserInfo* userInfo = [self Login:[GlobalContext GetUserInfo].userno password:[GlobalContext GetUserInfo].password];
            if (![userInfo isNil])
            {
                if ([GlobalContext UserInfoIsStored])
                {
                    [GlobalContext SaveUserInfo:userInfo];
                }else
                {
                    [GlobalContext SetUserInfo:userInfo];
                }
                
                return [self dealBillByStr:userInfo.sid dealType:dealType store:store bill:order];
            }else
            {
                return NO;
            }
        }else
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return NO;
        }
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return NO;
    }
}


+(bool)registerStore:(NSString *)sid store:(NSString *)strno lat:(double)lat lng:(double)lng
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/registerStore\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><registerStore xmlns=\"http://tempuri.org/\"><sid>%@</sid><strno>%@</strno><lat>%f</lat><lng>%f</lng></registerStore></S:Body></S:Envelope>",sid, strno ,lat, lng];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return NO;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<registerStoreResult>"];
    NSRange end = [result rangeOfString:@"</registerStoreResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    id json = [s JSONValue];
    if ([json isKindOfClass:[NSDictionary class]]) {
        json = (NSDictionary*)json;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSString* jsonStr = [NSString stringWithFormat:@"{\"list\":%@}", s];
        json = [jsonStr JSONValue];
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return NO;
    }
    
    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        if ([status isEqualToString:@"8"])
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return YES;
        }else if ([status isEqualToString:@"2"])
        {
            UserInfo* userInfo = [self Login:[GlobalContext GetUserInfo].userno password:[GlobalContext GetUserInfo].password];
            if (![userInfo isNil])
            {
                if ([GlobalContext UserInfoIsStored])
                {
                    [GlobalContext SaveUserInfo:userInfo];
                }else
                {
                    [GlobalContext SetUserInfo:userInfo];
                }
                
                return [self registerStore:userInfo.sid store:strno lat:lat lng:lng];
            }else
            {
                return NO;
            }
        }else
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return NO;
        }
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return NO;
    }
}

+(bool)signInAndOut:(NSString *)sid userno:(NSString *)userno store:(NSString *)strno lat:(double)lat lng:(double)lng
{
    NSURL *url = [NSURL URLWithString: urlStr];
    
    request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTimeOutSeconds:TIMEOUT];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"SOAPAction" value:@"\"http://tempuri.org/signInAndOut\""];
    [request addRequestHeader:@"Accept" value:@"text/xml, multipart/related, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=\"UTF-8\""];
    [request addRequestHeader:@"Host" value: host];
    
    NSString *strData = [NSString stringWithFormat:@"<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><signInAndOut xmlns=\"http://tempuri.org/\"><sid>%@</sid><userno>%@</userno><strno>%@</strno><lat>%f</lat><lng>%f</lng></signInAndOut></S:Body></S:Envelope>",sid, userno, strno ,lat, lng];
    
    NSMutableData *postData = [NSMutableData dataWithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postData];
    
    [request startSynchronous];
    
    if ([request error] != nil)
    {
        [self ShowDialog:[[request error] localizedDescription]];
        return NO;
    }
    
    NSString* result = [request responseString];
    NSRange start = [result rangeOfString:@"<signInAndOutResult>"];
    NSRange end = [result rangeOfString:@"</signInAndOutResult>"];
    NSString* s = [result substringWithRange:NSMakeRange(start.location + start.length, end.location - (start.location + start.length))];
    
    id json = [s JSONValue];
    if ([json isKindOfClass:[NSDictionary class]]) {
        json = (NSDictionary*)json;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSString* jsonStr = [NSString stringWithFormat:@"{\"list\":%@}", s];
        json = [jsonStr JSONValue];
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return NO;
    }
    
    NSString* status = [json objectForKey:@"status"];
    
    if (status != nil)
    {
        if ([status isEqualToString:@"8"])
        {
            NSString* message = [NSString stringWithFormat:@"%@\n距离店铺：%@", [json objectForKey:@"message"], [json objectForKey:@"distance"]];
            
            [self ShowDialog:message];
            return YES;
        }else if ([status isEqualToString:@"2"])
        {
            UserInfo* userInfo = [self Login:[GlobalContext GetUserInfo].userno password:[GlobalContext GetUserInfo].password];
            if (![userInfo isNil])
            {
                if ([GlobalContext UserInfoIsStored])
                {
                    [GlobalContext SaveUserInfo:userInfo];
                }else
                {
                    [GlobalContext SetUserInfo:userInfo];
                }
                
                return [self signInAndOut:userInfo.sid userno:userInfo.userno store:strno lat:lat lng:lng];
            }else
            {
                return NO;
            }
        }else
        {
            NSString* message = [json objectForKey:@"message"];
            [self ShowDialog:message];
            return NO;
        }
    }else
    {
        [self ShowDialog:@"数据格式错误"];
        return NO;
    }
}


+(void)ShowDialog:(id)text
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
