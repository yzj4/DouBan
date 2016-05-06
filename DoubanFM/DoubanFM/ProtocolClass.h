//
//  ProtocolClass.h
//  
//
//  Created by l k j y on 16/5/5.
//
//

#import <Foundation/Foundation.h>
@protocol DoubanDelegate <NSObject>
@optional
-(void)setCaptchaImageWithURLInstring:(NSString *)url;

-(void)loginSuccess;
-(void)logoutSuccess;

-(void)reloadTableViewData;
-(void)initSongInfomation;

-(void)setUserInfo;

-(void)menuButtonClicked:(int)index;
@end

@interface ProtocolClass : NSObject

@end
