//
//  util.m
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "util.h"
static util * utilSharedInstance = nil;
@implementation util

+(util*)sharedInstance
{
    if(utilSharedInstance == nil)
    {
        utilSharedInstance = [[util alloc] init];
    }
    return utilSharedInstance;
}
//从某个时间后的多少秒获取特定时间的显示格式
+(NSString*)getDateStringfordataFormant:(NSString*)formatString forData:(NSDate*)date;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatString];
    
    return [dateFormatter stringFromDate:date];
    [dateFormatter release];
}
+(NSDate*)getDateFromString:(NSString*)dateString andFromant:(NSString*)formatString;
{
    NSDateFormatter * inputFormatter =[[[NSDateFormatter alloc] init] autorelease];
    [inputFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    [inputFormatter setDateFormat:formatString];
    return [inputFormatter dateFromString:dateString];
}
@end
