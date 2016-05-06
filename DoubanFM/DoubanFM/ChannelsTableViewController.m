//
//  ChannelsTableViewController.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import "ChannelsTableViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface ChannelsTableViewController (){
    AFHTTPRequestOperationManager *manager;
    AppDelegate *appDelegate;
    NetworkManager *networkManager;
    PalyController *playerController;

}

@end

@implementation ChannelsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 80;
    self.tableView.rowHeight = 60;
    appDelegate = [[UIApplication sharedApplication]delegate];
    networkManager = [[NetworkManager alloc]init];
    networkManager.delegate = self;
    playerController = [[PalyController alloc]init];
    UINib *cell = [UINib nibWithNibName:@"ChannelsTableViewCell" bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:@"theReuseIdentifier"];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(initChannelInfo)];
    [self.tableView.header setTitle:@"往下拉刷新" forState:MJRefreshHeaderStateIdle];
    [self.tableView.header setTitle:@"松开刷新" forState:MJRefreshHeaderStatePulling];
    [self.tableView.header setTitle:@"刷新中" forState:MJRefreshHeaderStateRefreshing];
    
    self.tableView.header.font = [UIFont systemFontOfSize:15];
    
    self.tableView.header.textColor = [UIColor grayColor];
    [self.tableView.header beginRefreshing];
    [self viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initChannelInfo{
    if (appDelegate.userInfo.cookies == nil) {
        [networkManager setChannel:1 withURLWithString:@"http://douban.fm/j/explore/get_recommend_chl"];
    }
    else{
        [networkManager setChannel:1 withURLWithString:[NSString stringWithFormat:@"http://douban.fm/j/explore/get_login_chls?uk=%@",appDelegate.userInfo.userID]];
    }
    [networkManager setChannel:2 withURLWithString:@"http://douban.fm/j/explore/up_trending_channels"];
    [networkManager setChannel:3 withURLWithString:@"http://douban.fm/j/explore/hot_channels"];
    [self.tableView.header endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[ChannelInfo channelsTitleArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ChannelInfo channels] objectAtIndex:section] count];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[ChannelInfo channelsTitleArray] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"theReuseIdentifier";
    ChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[[[ChannelInfo channels] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [ChannelInfo updateCurrentCannel:[[[ChannelInfo channels] objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
    [networkManager loadPlaylistwithType:@"n"];
    [self.delegate menuButtonClicked:0];
}

- (void)reloadTableviewData{
    [self.tableView reloadData];
}





@end
