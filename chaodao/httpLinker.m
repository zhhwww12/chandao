//
//  httpLinker.m
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "httpLinker.h"
#import "JSON.h"
@implementation httpLinker
@synthesize request;
static httpLinker * shareInstance = nil;
+(httpLinker*)sharedHttpLinker
{
    if(shareInstance == nil)
    {
        shareInstance = [[httpLinker alloc] init];
        
    }
    return  shareInstance;
}
- (id)init
{
    self = [super init];
    if (self) {
        request = [[NSMutableURLRequest alloc] init];
    }
    return self;
}
//获取session
-(NSDictionary *)getSession
{
    NSString * urlString = [NSString stringWithFormat:@"%@?m=api&f=getSessionID&t=json",CHANDAO_URL];
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPShouldHandleCookies:YES];
    [request setHTTPMethod:@"POST"];
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil)
    {
        return [[strRet JSONValue] autorelease];
        
    }
    else
    {
        return nil;
    }
    
}
//登陆
-(NSDictionary *)loginWithuserName:(NSString*)userName andpassword:(NSString *)password
{
    
    // request = [NSMutableURLRequest new];
    NSString * urlString = [NSString stringWithFormat:@"%@?m=user&f=login&account=%@&password=%@&t=json",CHANDAO_URL,userName,password];
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil)
    {
        return [strRet JSONValue] ;
        
    }
    else
    {
        return nil;
    }
}
//获取自己的待办事项
-(NSDictionary *)getCmyDaiban{
    
    NSString * urlString = [NSString stringWithFormat:@"%@?m=my&f=todo&t=html&type=all&account=&status=all&orderBy=date,status,begin&recTotal=20&recPerPage=1000&pageID=1&t=json",CHANDAO_URL];

    
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil)
    {
        return [strRet JSONValue] ;
        
    }
    else
    {
        return nil;
    }
}
//推出登陆
-(NSDictionary *)logOutChanDao
{
    NSString * urlString = [NSString stringWithFormat:@"%@?m=user&f=logout&t=json",CHANDAO_URL];
    
    
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil)
    {
        return [strRet JSONValue] ;
        
    }
    else
    {
        return nil;
    }
    
}
//增加待办事项
-(NSDictionary *)aditemforitemDic:(NSDictionary*)dic
{
    NSDate * date = [NSDate date];
   
    
    NSString * dateString = [util getDateStringfordataFormant:@"yyyyMMdd" forData:date];
    
    NSString * urlString = [NSString stringWithFormat:@"%@?m=todo&f=create&date=%@&t=json",CHANDAO_URL,dateString];
     NSURL * url = [NSURL URLWithString:urlString];

    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];
    
    NSMutableString * bodyString = [[NSMutableString alloc] initWithFormat:@"&type=%@&pri=%@&name=%@&desc=%@&status=%@",
                                    [dic objectForKey:@"type"],
                                    [dic objectForKey:@"pri"],
                                    [dic objectForKey:@"name"],
                                    [dic objectForKey:@"desc"],
                                    [dic objectForKey:@"status"]];

    if(![[dic valueForKey:@"date"] isEqualToString:UNDT_DATE])
    {
        [bodyString appendFormat:@"&date=%@",[dic objectForKey:@"date"]];
        
    }
    if(![[dic valueForKey:@"begin"] isEqualToString:UNDT_DATE])
    {
        [bodyString appendFormat:@"&begin=%@&end=%@",[dic objectForKey:@"begin"],
         [dic objectForKey:@"end"]];
    }
    if(![[dic valueForKey:@"private"] isEqualToString:UNDT_DATE])
    {
        [bodyString appendString:@"&private=1"];
    }
    
    NSData * tijiaodata = [bodyString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];  ;
    
    NSString *postLength = [NSString stringWithFormat:@"%d",[tijiaodata length]];
    NSLog(@"postLength=%@",postLength);
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // [request setValue:@"http-equiv" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"txt/html" forHTTPHeaderField:@"content"];
    
    [request setHTTPBody:tijiaodata];
    NSLog(@"adderror = %@",[request debugDescription]);
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil||strRet != NULL)
    {
        return [strRet JSONValue] ;
        
    }
    else
    {
        return nil;
    }
}

//完成待办事项

-(NSDictionary *)compleitemforId:(NSNumber*)idindex
{
    NSString * urlString = [NSString stringWithFormat:@"%@?m=todo&f=finish&id=%@&t=json",CHANDAO_URL,idindex];
    
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil)
    {
        return [strRet JSONValue] ;
        
    }
    else
    {
        return nil;
    }
}
//提交改过的待办事项
-(NSDictionary *)edititemfordic:(NSDictionary*)dic{
    
    
    NSString * itemId = [dic objectForKey:@"id"];
    NSString * urlString = [NSString stringWithFormat:@"%@?m=todo&f=edit&todoID=%@&t=json",CHANDAO_URL,itemId];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];

    NSMutableString * bodyString = [[NSMutableString alloc] initWithFormat:@"&type=%@&pri=%@&name=%@&desc=%@&status=%@",
                                    [dic objectForKey:@"type"],
                                    [dic objectForKey:@"pri"],
                                    [dic objectForKey:@"name"],
                                    [dic objectForKey:@"desc"],
                                    [dic objectForKey:@"status"]];
    
    if(![[dic valueForKey:@"date"] isEqualToString:UNDT_DATE])
    {
        [bodyString appendFormat:@"&date=%@",[dic objectForKey:@"date"]];
        
    }
    if(![[dic valueForKey:@"begin"] isEqualToString:UNDT_DATE])
    {
        [bodyString appendFormat:@"&begin=%@&end=%@",[dic objectForKey:@"begin"],
         [dic objectForKey:@"end"]];
    }
    if([[dic valueForKey:@"private"] isEqualToString:UNDT_DATE])
    {
        [bodyString appendString:@"&private=1"];
    }
    NSData * tijiaodata = [bodyString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];  ;
    
    NSString *postLength = [NSString stringWithFormat:@"%d",[tijiaodata length]];
    NSLog(@"postLength=%@",postLength);
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // [request setValue:@"txt/html" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:tijiaodata];
    NSLog(@"adderror = %@",[request debugDescription]);
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil)
    {
        return [strRet JSONValue] ;
        
    }
    else
    {
        return nil;
    }
}
//删除待办事项

-(NSDictionary *)delitemforId:(NSNumber*)idindex
{
    NSString * urlString = [NSString stringWithFormat:@"%@?m=todo&f=delete&todoID=%@&confirm=yes&t=json",CHANDAO_URL,idindex];
    
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(strRet!=nil)
    {
        return [strRet JSONValue] ;
        
    }
    else
    {
        return nil;
    }
}
@end
