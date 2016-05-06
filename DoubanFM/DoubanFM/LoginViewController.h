//
//  LoginViewController.h
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "NetworkManager.h"
#import "AppDelegate.h"
#import "ProtocolClass.h"
@interface LoginViewController : UIViewController <DoubanDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *captchaImageView;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *captcha;

@property (weak,nonatomic)id<DoubanDelegate>delegate;
- (IBAction)login:(id)sender;

- (IBAction)cancel:(id)sender;

- (IBAction)backgroudTap:(id)sender;


@end
