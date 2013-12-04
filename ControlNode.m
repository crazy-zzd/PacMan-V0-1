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
        
        [self initMaps];
        
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

- (void)initMaps
{
    theMap = [Maps sharedMap];
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
        [self schedule:@selector(updatePlayer:) interval:PLAYER_SPEED];
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
    CGPoint oldPosition = [player mapPosition];
    CGPoint newPosition = ccpAdd([player mapPosition], movement);
    [player setPosition:newPosition];
    
    if ([self isCrashedWallWithPointPosition:[player pointPosition] withPosition:[player mapPosition]]) {
        [player setPosition:oldPosition];
    }
    
    
    CCLOG(@"x=%f,y=%f",player.sprite.position.x,player.sprite.position.y);
    CCLOG(@"%f,%f",[player pointPosition].x,[player pointPosition].y);
}

//只通过图坐标实现碰撞，通过中心图坐标计算出四个角的图坐标。
//图坐标实现有问题，给定一个图坐标无法确定这个点是不是有障碍物，因为在分界线上总共有两种可能。可能可以解决的方法：看看是哪个点的坐标
//- (BOOL)isCrashedWallWithPosition:(CGPoint)thePosition
//{
//    BOOL isCrashed;
//    
//    return isCrashed;
//}


//通过点坐标和图坐标实现碰撞
- (BOOL)isCrashedWallWithPointPosition:(CGPoint)thePointPosition withPosition:(CGPoint)thePosition
{
    //第一种方法检测是否撞墙
    int thePosX,thePosY;
    thePosX = thePosition.x - (PLAYVIEW_X + POINT_LENGTH * thePointPosition.x + 0.5 * POINT_LENGTH);
    thePosY = thePosition.y - (PLAYVIEW_Y + POINT_LENGTH * thePointPosition.y + 0.5 * POINT_LENGTH);
    BOOL isCrashed = NO;
    if (thePosX > 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y)];
        
    }
    if (thePosX < 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y)];
    }
    if (thePosY > 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x, thePointPosition.y + 1)];
    }
    if (thePosY < 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x, thePointPosition.y - 1)];
    }
    if ((thePosX > 0)&&(thePosY > 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y + 1)];
    }
    if ((thePosX < 0)&&(thePosY > 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y + 1)];
    }
    if ((thePosX > 0)&&(thePosY < 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y - 1)];
    }
    if ((thePosX < 0)&&(thePosY < 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y - 1)];
    }
    return isCrashed;
}


@end
