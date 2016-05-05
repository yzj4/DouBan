//
//  CDSideBarController.h
//  DoubanFM
//
//  Created by l k j y on 16/5/5.
//  Copyright © 2016年 尹照俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CDSideBarControllerDelegate <NSObject>

-(void)menuButtonClicked:(int)index;

@end

@interface CDSideBarController : NSObject
{
    UIView* _backgroundMenuView;/**<背景菜单栏*/
    UIButton* _menuButton;/**<菜单按钮*/
    NSMutableArray* _buttonList;/**<按钮列表*/
}

@property(nonatomic,retain)UIColor* menuColor;
@property(nonatomic)BOOL isOpen;
@property(nonatomic,weak)id<CDSideBarControllerDelegate>delegate;

+(CDSideBarController*)sharedInstanceWithImages:(NSArray*)images;
+(CDSideBarController*)sharedInstance;
-(CDSideBarController*)initWithImages:(NSArray*)buttonList;
-(void)insertMenuOnView:(UIView*)view atPosition:(CGPoint)point;
-(void)dismissMenu;

@end

