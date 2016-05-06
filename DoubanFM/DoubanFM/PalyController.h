//
//  PalyController.h
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NetworkManager.h"
#import "ProtocolClass.h"
@interface PalyController : MPMoviePlayerController
@property id<DoubanDelegate> songInfoDelegate;

@property (nonatomic) DFMPlaylist *playList;

+ (instancetype)sharedInstance;

-(instancetype)init;
-(void)startPlay;

-(void)pauseSong;
-(void)restartSong;
-(void)likeSong;
-(void)dislikeSong;
-(void)deleteSong;
-(void)skipSong;

@end
