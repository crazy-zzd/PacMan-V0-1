//
//  GameLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-15.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TouchLayerDelegate.h"
#import "MyHeader.h"

#import "ControlNodeDelegate.h"

#define TIME_MAX 120.0

@class PauseLayer;
@class TouchLayer;

@class CountDownLayer;
@class ControlNode;
@class PlayerMan;
@class MonsterMan;
@class Beans;

@class GameData;

@class TimeSprite;

@interface GameLayer : CCLayer<TouchLayerDelegate, ControlNodeDelegate> {
    TouchLayer * theTouchLayer;
    ControlNode * theControNode;
    
    CountDownLayer * theCountDownLayer;
    
    GameData * mainGameData;
    
    enum GameStyle mainGameStyle;
    
    //计时器
    TimeSprite * timeLine;
    
    GLfloat restTime;
}

@property (nonatomic, strong)TouchLayer * theTouchLayer;
@property (nonatomic, strong)ControlNode * theControNode;

@property (nonatomic, assign)enum GameStyle mainGameStyle;

+(CCScene *)SceneWithStyle:(enum GameStyle)theStyle;



@end
