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


#define PLAYER_SPEED 0

#define MONSTERS_TIME 0

@class Man;
@class PlayerMan;
@class MonsterMan;
@class Beans;
@class Maps;

@interface ControlNode : CCNode {
    PlayerMan * player;
    NSMutableArray * monsters;
    NSMutableArray * beans;
    
    CCLabelTTF * score;
    
    Maps * theMap;
    
    enum gameState stateNow;
    
}

@property PlayerMan * player;
@property NSMutableArray * monsters;
@property NSMutableArray * beans;
@property CCLabelTTF * score;

- (void)moveWithDirection:(int)theDirection;
- (void)startMoving;


@end
