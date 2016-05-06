//
//  NetworkManager.h
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolClass.h"

@interface NetworkManager : NSObject

@property (weak, nonatomic)id<DoubanDelegate>delegate;
@property (nonatomic) NSMutableArray *captchaID;

+ (instancetype)sharedInstancd;

-(instancetype)init;

-(void)setChannel:(NSUInteger)channelIndex withURLWithString:(NSString *)urlWithString;

-(void)LoginwithUsername:(NSString *)username Password:(NSString *)password Captcha:(NSString *)captcha RemeberOnorOff:(NSString *)rememberOnorOff;

-(void)logout;

-(void)loadCaptchaImage;

-(void)loadPlaylistwithType:(NSString *)type;


@end
