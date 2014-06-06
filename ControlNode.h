//
//  ControlNode.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"
#import "PauseLayerDelegate.h"

@class Man;
@class PlayerMan;
@class MonsterMan;
@class Beans;
@class Maps;
@class PauseLayer;
@class GameLayer;
@class StartLayer;

@class GameData;

@interface ControlNode : CCNode<PauseLayerDelegate> {
    //游戏数据
    GameData * mainGameData;
    
    PlayerMan * player;
    NSMutableArray * monsters;
    NSMutableArray * beans;
    
    CCLabelTTF * score;
    
    Maps * theMap;
    
    enum gameState stateNow;
    
    PauseLayer * thePauseLayer;
}

@property PlayerMan * player;
@property NSMutableArray * monsters;
@property NSMutableArray * beans;
@property CCLabelTTF * score;

- (void)moveWithDirection:(int)theDirection;
- (void)playerJump;

- (void)onPressPause;
- (void)gameStart;
- (void)gameOver;

@end
