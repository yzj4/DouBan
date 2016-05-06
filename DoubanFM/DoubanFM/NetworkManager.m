//
//  NetworkManager.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import "NetworkManager.h"
#import "AppDelegate.h"
#import "SongInfo.h"
#import "ChannelInfo.h"

#import "PalyController.h"

#import "DFMUpChannelsEntity.h"
#import "DFMHotChannelsEntity.h"
#import "DFMRecChannelsEntity.h"

#import <UIKit/UIKit.h>

#import <MJExtension.h>
#import <AFNetworking/AFNetworking.h>

#define PLAYLISTURLFORMATSTRING @"http://douban.fm/j/mine/playlist?type=%@&sid=%@&pt=%f&channel=%@&from=mainsite"
#define LOGINURLSTRING @"http://douban.fm/j/login"
#define LOGOUTURLSTRING @"http://douban.fm/partner/logout"
#define CAPTCHAIDURLSTRING @"http://douban.fm/j/new_captcha"
#define CAPTCHAIMGURLFORMATSTRING @"http://douban.fm/misc/captcha?size=m&id=%@"

static NSMutableArray *captchaID;

@interface NetworkManager(){
    AppDelegate *appDelegate;
    AFHTTPRequestOperationManager *manager;


}
@end

@implementation NetworkManager
-(instancetype)init{
    if (self = [super init]) {
        appDelegate = [[UIApplication sharedApplication] delegate];
        manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

+ (instancetype)sharedInstancd
{
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

-(void)setChannel:(NSUInteger)channelIndex withURLWithString:(NSString *)urlWithString
{
    [manager GET:urlWithString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *channelsDictionary = responseObject;
        NSDictionary *tempChannel = [channelsDictionary objectForKey:@"data"];
        
        if (channelIndex == DFMChannelTypeUpTrending)
        {
            DFMUpChannelsEntity *entity = [DFMUpChannelsEntity objectWithKeyValues:tempChannel];
            [ChannelInfo channels][channelIndex] = entity.channels;
        }
        else if (channelIndex == DFMChannelTypeHot){
            DFMHotChannelsEntity *entity = [DFMHotChannelsEntity objectWithKeyValues:tempChannel];
            [ChannelInfo channels][channelIndex] = entity.channels;
        }
        else{
            NSDictionary *channels = [tempChannel objectForKey:@"res"];
            if ([[channels allKeys]containsObject:@"rec_chls"]) {
                for (NSDictionary *tempRecCannels in [channels objectForKey:@"rec_chls"]) {
                    ChannelInfo *channelInfo = [ChannelInfo objectWithKeyValues:tempRecCannels];
                    [[[ChannelInfo channels] objectAtIndex:channelIndex] addObject:channelInfo];
                }
            } else {
                NSDictionary *channels = [tempChannel objectForKey:@"res"];
                ChannelInfo *channelInfo = [ChannelInfo objectWithKeyValues:channels];
                [[[ChannelInfo channels] objectAtIndex:channelIndex] addObject:channelInfo];
             }
        }
        [self.delegate reloadTableViewData];
    }
         failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
   
}
-(void)logout{

    NSDictionary *logoutParameters = @{@"source":@"radio",@"ck":appDelegate.userInfo.cookies,@"no_login":@"y"};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:LOGOUTURLSTRING parameters:logoutParameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"LOGOUT_SUCCESSFUL");
        appDelegate.userInfo = [[UserInfo alloc]init];
        [appDelegate.userInfo archiverUserInfo];
        [self.delegate logoutSuccess];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"LOGOUT_ERROR:%@",error);
    }];
}

-(void)loadPlaylistwithType:(NSString *)type{
    NSString *playlistURLString = [NSString stringWithFormat:PLAYLISTURLFORMATSTRING,type,[SongInfo currentSong].sid,[PalyController sharedInstance].currentPlaybackTime,[ChannelInfo currentChannel].ID];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:playlistURLString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        DFMPlaylist *playList = [PalyController sharedInstance].playList;
        NSDictionary *songDictionary = responseObject;
        
        playList = [DFMPlaylist objectWithKeyValues:songDictionary];
        if ([type isEqualToString:@"r"])
        {
            [SongInfo setCurrentSongIndex:-1];
        }
        else{
            if ([playList.song count] != 0) {
                [SongInfo setCurrentSongIndex:0];
                [SongInfo setCurrentSong:[playList.song objectAtIndex:[SongInfo currentSongIndex]]];
                [[PalyController sharedInstance]setContentURL:[NSURL URLWithString:[SongInfo currentSong].url]];
                [[PalyController sharedInstance] play];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"HeyMan" message:@"红心列表中没有歌曲，请您先登录，或者添加红心歌曲" delegate:self cancelButtonTitle:@"GET" otherButtonTitles: nil];
                [alertView show];
                ChannelInfo *myPrivateChannel = [[ChannelInfo alloc]init];
                myPrivateChannel.name = @"我的私人";
                myPrivateChannel.ID = @"0";
                [ChannelInfo updateCurrentCannel:myPrivateChannel];
            
            
            }
        }
        [self.delegate reloadTableViewData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];

}


@end
