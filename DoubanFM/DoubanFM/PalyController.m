//
//  PalyController.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import "PalyController.h"
#import "SongInfo.h"

@interface PalyController()
{
    AppDelegate *appDelegate;
    NetworkManager *networkManager;
}
@end

@implementation PalyController
-(instancetype)init
{
    if (self = [super init])
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startPlay) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    return self;
}

+ (instancetype)sharedInstance
{
    static PalyController *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)initSongInfomation
{
    [self.songInfoDelegate initSongInfomation];
}

-(void)startPlay{
    @try {
        if ([SongInfo currentSongIndex] >= ((int)[[PalyController sharedInstance].playList.song count]-1)) {
            [networkManager loadPlaylistwithType:@"p"];
        }
        else{
            [SongInfo setCurrentSongIndex:[SongInfo currentSongIndex] + 1];
            [SongInfo setCurrentSong:[[PalyController sharedInstance].playList.song objectAtIndex:[SongInfo currentSongIndex]]];
            
            [self setContentURL:[NSURL URLWithString:[[SongInfo currentSong] valueForKey:@"url"]]];
            [self play];
        }
    }
    @catch (NSException *exception) {
    }
}

#pragma mark - PlayerButtonTask
-(void)pauseSong{
    [self pause];

}
-(void)restartSong{
    [self play];
}
-(void)likeSong{
    [networkManager loadPlaylistwithType:@"r"];
}
-(void)dislikeSong{
    [networkManager loadPlaylistwithType:@"u"];
}
-(void)deleteSong{
    [networkManager loadPlaylistwithType:@"b"];
}
-(void)skipSong{
    [networkManager loadPlaylistwithType:@"s"];
}
@end
