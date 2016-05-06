//
//  UserInfoViewController.h
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIKit+AFNetworking.h>
#import "LoginViewController.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
#import "ProtocolClass.h"
@interface UserInfoViewController : UIViewController<DoubanDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *loginImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playedLabel;
@property (weak, nonatomic) IBOutlet UILabel *likedLabel;
@property (weak, nonatomic) IBOutlet UILabel *bannedLabel;
@property (weak, nonatomic) IBOutlet UIButton *logout;
- (IBAction)logout:(id)sender;
- (void)setUserInfo;
- (void)logoutSuccess;
@end
