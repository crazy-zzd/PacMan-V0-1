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
@class Beans;


@interface PlayerMan : Man {
    int score;
    
    BOOL isJumping;
    
    BOOL isDouble;
}


-(BOOL)isCrashedWithRect:(CGRect)theRect;

-(BOOL)isContainWithRect:(CGRect)theRect;

-(void)eatBean:(Beans *)theBean;

-(BOOL)jump;

-(int)score;

-(void)startDouble;

@end
