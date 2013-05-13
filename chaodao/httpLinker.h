//
//  httpLinker.h
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "util.h"
#define CHANDAO_URL  [[NSUserDefaults standardUserDefaults] valueForKey:@"serverAddress"]

#define UNDT_DATE @"undeterminedTime"

@interface httpLinker : NSObject
{
    
    NSMutableURLRequest * request;
}
@property(nonatomic,retain)NSMutableURLRequest * request;
+(httpLinker*)sharedHttpLinker;
//获取session
-(NSDictionary *)getSession;
//登陆
-(NSDictionary *)loginWithuserName:(NSString*)userName andpassword:(NSString *)password;
//获取我的待办事项
-(NSDictionary *)getCmyDaiban;
//增加待办事项
-(NSDictionary *)aditemforitemDic:(NSDictionary*)dic;
//提交改过的待办事项
-(NSDictionary *)edititemfordic:(NSDictionary*)dic;
//删除待办事项
-(NSDictionary *)delitemforId:(NSNumber*)idindex;
//完成待办事项
-(NSDictionary *)compleitemforId:(NSNumber*)idindex;
//推出登陆
-(NSDictionary *)logOutChanDao;

@end
