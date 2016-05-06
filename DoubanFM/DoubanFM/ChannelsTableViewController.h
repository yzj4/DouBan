//
//  ChannelsTableViewController.h
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "ChannelsTableViewCell.h"
#import "ChannelInfo.h"
#import "AppDelegate.h"
#import "NetworkManager.h"
#import "ProtocolClass.h"
#import "PalyController.h"

@interface ChannelsTableViewController : UITableViewController<DoubanDelegate>

@property (nonatomic, weak) id<DoubanDelegate> delegate;

@property(nonatomic) NSMutableArray *channels;
@property(nonatomic) NSArray *channelsTitle;
@property(nonatomic) NSArray *myChannels;
@property(nonatomic) NSMutableArray *recommendChannels;
@property(nonatomic) NSMutableArray *upTrendingChannels;
@property(nonatomic) NSMutableArray *hotChannels;




@end
