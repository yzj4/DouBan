//
//  SidebarController.m
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//


#import "SidebarController.h"
#import "PlayerViewController.h"
#import "ChannelsTableViewController.h"

@interface SidebarController (){
    CDSideBarController *sideBar;
    PlayerViewController *playerVC;
    ChannelsTableViewController *channelsVC;
    UserInfoViewController *userInfoVC;
    AppDelegate *appDelegate;
}

@end

@implementation SidebarController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication]delegate];
    // Do any additional setup after loading the view from its nib.
    NSArray *imageList = @[[UIImage imageNamed:@"menuPlayer"],
                           [UIImage imageNamed:@"menuChannel"],
                           [UIImage imageNamed:@"menuLogin"],
                           [UIImage imageNamed:@"menuClose.png"]];
    
    sideBar = [CDSideBarController sharedInstanceWithImages:imageList];
    sideBar.delegate = self;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    playerVC = [[PlayerViewController alloc] init];
    
    channelsVC = [[ChannelsTableViewController alloc]init];
    channelsVC.delegate = (id)self;
    
    userInfoVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"userInfoVC"];
    self.viewControllers = @[playerVC, channelsVC, userInfoVC];
    
}





-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
    
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
    
    [sideBar insertMenuOnView:self.view atPosition:CGPointMake(self.view.frame.size.width-50, 30)];
}

#pragma mark - CDSidebar Delegate
-(void)menuButtonClicked:(int)index{
    self.selectedIndex = index;
    switch (index) {
        case 0:
        case 1:
        case 2:
            self.selectedIndex = index;
            break;
        case 3:
            break;
    }
}

@end
