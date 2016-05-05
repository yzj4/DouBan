//
//  DFMPlaylist.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import "DFMPlaylist.h"
#import "SongInfo.h"

@implementation DFMPlaylist

+(NSDictionary*)objectClassInArray
{
    return @{@"song":NSStringFromClass([SongInfo class])};
}

@end
