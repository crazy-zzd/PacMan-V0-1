//
//  ControlNode.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "ControlNode.h"


#import "Man.h"
#import "PlayerMan.h"
#import "MonsterMan.h"
#import "Beans.h"
#import "Maps.h"

@implementation ControlNode

@synthesize player;
@synthesize monsters;
@synthesize beans;

#pragma mark - 初始化

- (id)init
{
    if (self = [super init]) {
        
        [self initPlayer];
        
        [self initMonsters];
        
        [self initBeans];
        
        stateNow = gamePause;
    }
    return self;
}

- (void)initPlayer
{
    player = [[PlayerMan alloc] init];
}

- (void)initMonsters
{
    MonsterMan * firstMonster = [[MonsterMan alloc] init];
    
    monsters = [[NSMutableArray alloc] init];
    [monsters addObject:firstMonster];
    
}

- (void)initBeans
{
    Beans * firstBeans = [[Beans alloc] init];
    
    beans = [[NSMutableArray alloc] init];
    [beans addObject:firstBeans];
}


#pragma mark - 对外接口
#pragma mark - 移动接口

- (void)moveWithDirection:(int)theDirection
{
    player.direction = theDirection;
}

#pragma mark - 玩家开始移动或者暂停移动

- (void)startMoving
{
    if (stateNow == gameStart) {
        stateNow = gamePause;
        [self unschedule:@selector(updatePlayer:)];
    }
    else
    {
        stateNow = gameStart;
        [self schedule:@selector(updatePlayer:)];
    }
}

#pragma mark - 私有方法

#pragma mark - 玩家移动

- (void)updatePlayer:(ccTime)delta
{
    CGPoint movement;
    switch (player.direction) {
        case upDirection:
            movement = PLAYER_MOVEUP;
            break;
        case downDirection:
            movement = PLAYER_MOVEDOWN;
            break;
        case leftDirection:
            movement = PLAYER_MOVELEFT;
            break;
        case rightDirection:
            movement = PLAYER_MOVERIGHT;
            break;
        default:
            break;
    }
    [player setPosition:ccpAdd([player mapPosition], movement)];
    
    CCLOG(@"%f,%f",[player pointPosition].x,[player pointPosition].y);
}

- (BOOL)isCrashedWall:(CGPoint)thePointPosition
{
    Maps * theMap = [Maps sharedMap];
    return [theMap isWall:thePointPosition];
}


@end
