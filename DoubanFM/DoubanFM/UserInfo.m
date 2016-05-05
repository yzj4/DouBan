//
//  UserInfo.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
-(instancetype)initWithDictionary:( NSDictionary*)dictionary
{
    if (self=[super init])
    {
        self.isNotLogin=[dictionary valueForKey:@"r"];
        NSDictionary* tempUserInfoDic=[dictionary valueForKey:@"user_info"];
        self.cookies=[tempUserInfoDic valueForKey:@"ck"];
        self.userID=[tempUserInfoDic valueForKey:@"id"];
        self.name=[tempUserInfoDic valueForKey:@"name"];
        NSDictionary* tempPlayRecordDic=[tempUserInfoDic valueForKey:@"play_record"];
        self.banned=[NSString stringWithFormat:@"%@",[tempPlayRecordDic valueForKey:@"banned"]];
        self.liked=[NSString stringWithFormat:@"%@",[tempPlayRecordDic valueForKey:@"liked"]];
        self.played=[NSString stringWithFormat:@"%@",[tempPlayRecordDic valueForKey:@"played"]];
    }
    return self;
}
-(void)archiverUserInfo
{
    NSMutableData* data=[[NSMutableData alloc]init];
    NSKeyedArchiver* archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:@"userInfo"];
    [archiver finishEncoding];
    
    NSString* homePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Doucments"];
    NSString* appdelegatePath=[homePath stringByAppendingPathComponent:@"appdelegate.archiver"];
    
    //添加储存文件名
    if ([data writeToFile:appdelegatePath atomically:YES])
    {
        NSLog(@"UserInfo存储成功");
    }
}
@end
