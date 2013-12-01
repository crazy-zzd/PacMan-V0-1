//
//  HelloWorldScene.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-8.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"

#define TAG_DISPLAYLAYER 1
#define TAG_TOUCHLAYER 2

#define Z_DISPLAYLAYER 1
#define Z_TOUCHLAYER 2




@class TouchLayer;
@class DisplayLayer;
@class ControlNode;

@class Man;
@class PlayerMan;
@class MonsterMan;

@interface HelloWorldScene : CCScene {
    //三个层
    TouchLayer * theTouchLayer;
    DisplayLayer * theDisplayLayer;
    ControlNode  * theControlNode;
    
    //触摸消息标志
    int directionSymbol;
    
    //游戏对象
    PlayerMan * player;
    NSMutableArray * monsters;
    NSMutableArray * beans;
}

@property PlayerMan * player;
@property NSMutableArray * monsters;
@property NSMutableArray * beans;


//单例
//+(HelloWorldScene *)sharedScene;

+(HelloWorldScene *)Scene;

//接受发送消息
-(void)setDirectorSymbol:(int)theDirection;
-(int)getDirecitonSymbol;


@end
