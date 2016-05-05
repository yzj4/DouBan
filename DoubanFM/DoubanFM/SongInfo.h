//
//  SongInfo.h
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongInfo : NSObject
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* artist;
@property(nonatomic,copy)NSString* picture;
@property(nonatomic,copy)NSString* length;
@property(nonatomic,copy)NSString* like;
@property(nonatomic,copy)NSString* url;
@property(nonatomic,copy)NSString* sid;

+(instancetype)currentSong;
+(void)setCurrentSong:(SongInfo*)songInfo;
+(NSInteger)currentSongIndex;
+(void)setCurrentSongIndex:(int)songIndex;

@end
