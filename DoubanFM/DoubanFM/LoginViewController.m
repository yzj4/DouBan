//
//  LoginViewController.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkManager.h"
#import <UIImageView+AFNetworking.h>
@interface LoginViewController ()
{
    NSMutableArray *captchaID ;
    NetworkManager *networkManager;
    AppDelegate *appDelegate;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [UIApplication sharedApplication].delegate;
    networkManager = [[NetworkManager alloc]init];
    networkManager.delegate = (id)self;
    //初始化图片点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadCaptchaImage)];
    [singleTap setNumberOfTapsRequired:1];
    self.captchaImageView.userInteractionEnabled = YES;
    [self.captchaImageView addGestureRecognizer:singleTap];
}
-(void)viewWillAppear:(BOOL)animated
{
     [self loadCaptchaImage];
    [super viewWillAppear:animated];
}
-(void)setCapachaImageWithURLInString:(NSString*)url
{
    [self.captchaImageView setImageWithURL:[NSURL URLWithString:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(id)sender
{
    NSString *username = _username.text;
    NSString *password = _password.text;
    NSString *captcha = _captcha.text;
    [networkManager LoginwithUsername:username Password:password Captcha:captcha RemeberOnorOff:@"off"];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgroudTap:(id)sender
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [_captcha resignFirstResponder];
}
-(void)loadCaptchaImage
{
    [networkManager loadCaptchaImage];
}
-(void)loginSuccess
{
    [_delegate setUserInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
