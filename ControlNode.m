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
@synthesize score;

#pragma mark - 初始化

- (id)init
{
    if (self = [super init]) {
        
        [self initPlayer];
        
        [self initMonsters];
        
        [self initBeans];
        
        [self initMaps];
        
        [self initScore];
        
        stateNow = gamePause;
    }
    return self;
}

- (void)initPlayer
{
    player = [[PlayerMan alloc] initWithPointPosition:PLAYER_POINTPOSITION withDirection:PLAYER_DIRECTION];
}

- (void)initMonsters
{
    MonsterMan * firstMonster = [[MonsterMan alloc] initWithPointPosition:MONSTER_POINTPOSITION1 withDirection:MONSTER_DIRECTION1];
    MonsterMan * secondMonster = [[MonsterMan alloc]initWithPointPosition:MONSTER_POINTPOSITION2 withDirection:MONSTER_DIRECTION2];
    
    monsters = [[NSMutableArray alloc] init];
    [monsters addObject:firstMonster];
    [monsters addObject:secondMonster];
    
}

- (void)initBeans
{
    Beans * firstBeans = [[Beans alloc] initWithPosition:CGPointMake(3, 3) withScore:1];
    
    beans = [[NSMutableArray alloc] init];
    [beans addObject:firstBeans];
}

- (void)initMaps
{
    theMap = [Maps sharedMap];
}

- (void)initScore
{
    score = [[CCLabelTTF alloc] initWithString:@"0" fontName:Nil fontSize:20];
    score.position = ccp(100, 270);
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
        [self unschedule:@selector(updateMonsters:)];
//        [self stopMonstersAction];
    }
    else
    {
        stateNow = gameStart;
        [self schedule:@selector(updatePlayer:) interval:PLAYER_SPEED];
        [self schedule:@selector(updateMonsters:) interval:MONSTERS_TIME];
    }
}

- (void)gameOver
{
    exit(0);
}


#pragma mark - 私有方法

#pragma mark - 玩家移动

- (void)updatePlayer:(ccTime)delta
{
    [player move];
    [self crashMonsters];
    [self eatBeans];
}

- (void)crashMonsters
{
    MonsterMan * theMonster;
    for (int i = 0; i < [monsters count]; i ++) {
        theMonster = [monsters objectAtIndex:i];
        if ([player isCrashedWithRect:[theMonster spriteRect]]) {
            [self gameOver];
        }
    }
}

- (void)eatBeans
{
    Beans * theBean;
    for (int i = 0; i < [beans count]; i ++) {
        theBean = [beans objectAtIndex:i];
        if ([player isCrashedWithRect:[theBean spriteRect]]) {
            [theBean beEaten];
            [player eatBean];
            score.string = [NSString stringWithFormat:@"%d",player.score];
            [beans removeObjectAtIndex:i];
            i --;
        }
    }
}

- (void)updateMonsters:(ccTime)delta
{
    MonsterMan * theMonster;
    for (int i = 0; i < [monsters count]; i ++) {
        theMonster = [monsters objectAtIndex:i];
        [theMonster move];
    }
}



@end
