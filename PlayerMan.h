//
//  PlayerMan.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Man.h"
#import "MyHeader.h"

@class Maps;


@interface PlayerMan : Man {
    int score;
}

-(BOOL)isCrashedWithRect:(CGRect)theRect;

-(int)score;

-(void)eatBean;

@end
