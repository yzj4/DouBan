//
//  UserInfoViewController.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import "UserInfoViewController.h"
#import "CDSideBarController.h"
@interface UserInfoViewController ()
{
    NetworkManager *networkmanager;
    UIStoryboard *mainStoryboard;
    AppDelegate *appDelegate;
}
@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainStoryboard = [UIStoryboard storyboardWithName:@"Main "bundle:nil];
    appDelegate = [[UIApplication sharedApplication]delegate];
    //给登录图片添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginImageTapped)];
    [singleTap setNumberOfTapsRequired:1];
    self.loginImage.userInteractionEnabled = YES;
    [self.loginImage addGestureRecognizer:singleTap];
    networkmanager = [[NetworkManager alloc]init];
    networkmanager.delegate = (id)self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _loginImage.layer.cornerRadius = _loginImage.frame.size.width/2.0;
    if (!_loginImage.clipsToBounds)
    {
        _loginImage.clipsToBounds = YES;
    }
}

-(void)loginImageTapped
{
    LoginViewController *loginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginVC"];
    loginVC.delegate = (id)self;
    [[CDSideBarController sharedInstance]dismissMenu];
    [self presentViewController:loginVC animated:YES completion:nil];
}
- (IBAction)logout:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登出" message:@"您确定要登出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
            
        case 1:
            [networkmanager logout];
            break;
            
        default:
            break;
    }
}
-(void)setUserInfo
{
    if (appDelegate.userInfo.cookies)
    {
        [_loginImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img3.douban.com/icon/ul%@-1.jpg",appDelegate.userInfo.userID]]];
        _loginImage.userInteractionEnabled = NO;
        
        _usernameLabel.text = appDelegate.userInfo.name;
        _playedLabel.text = appDelegate.userInfo.played;
        _likedLabel.text = appDelegate.userInfo.liked;
        _bannedLabel.text = appDelegate.userInfo.banned;
        _logout.hidden = NO;
    }
    else
    {
        [_loginImage setImage:[UIImage imageNamed:@"login"]];
        _loginImage.userInteractionEnabled = YES;
        _usernameLabel.text = @"";
        _playedLabel.text = @"0";
        _likedLabel.text = @"0";
        _bannedLabel.text = @"0";
        _logout.hidden = YES;
        
    }
}
-(void)logoutSuccess
{
    [self setUserInfo];
}
@end
