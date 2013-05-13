//
//  util.h
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface util : NSObject
+(util*)sharedInstance;
//从某个时间后特定时间的显示格式
+(NSString*)getDateStringfordataFormant:(NSString*)formatString forData:(NSDate*)date;
+(NSDate*)getDateFromString:(NSString*)dateString andFromant:(NSString*)formatString;
@end
