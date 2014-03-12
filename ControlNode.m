//
//  ControlNode.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "ControlNode.h"

#import "GameLayer.h"
#import "StartLayer.h"

#import "Man.h"
#import "PlayerMan.h"
#import "MonsterMan.h"
#import "Beans.h"
#import "Maps.h"
#import "PauseLayer.h"
#import "EndLayer.h"

@implementation ControlNode

@synthesize player;
@synthesize monsters;
@synthesize beans;
@synthesize score;

#pragma mark - 初始化

- (id)init
{
    if (self = [super init]) {
        
        [self initMaps];
        
        [self initPlayer];
        
        [self initMonsters];
        
        [self initBeans];
        
        [self initScore];
        
        stateNow = gameBefore;
    }
    return self;
}

- (void)initPlayer
{
    player = [[PlayerMan alloc] initWithPointPosition:PLAYER_POINTPOSITION withDirection:PLAYER_DIRECTION];
}

- (void)initMonsters
{
    MonsterMan * firstMonster = [[MonsterMan alloc] initWithPointPosition:MONSTER_POINTPOSITION1 withDirection:MONSTER_DIRECTION1 withIndex:1];
    MonsterMan * secondMonster = [[MonsterMan alloc]initWithPointPosition:MONSTER_POINTPOSITION2 withDirection:MONSTER_DIRECTION2 withIndex:2];
    MonsterMan * thirdMonster = [[MonsterMan alloc]initWithPointPosition:MONSTER_POINTPOSITION3 withDirection:MONSTER_DIRECTION3 withIndex:3];
    
    monsters = [[NSMutableArray alloc] init];
    [monsters addObject:firstMonster];
    [monsters addObject:secondMonster];
    [monsters addObject:thirdMonster];
}

- (void)initBeans
{
    beans = [[NSMutableArray alloc] init];
    for (int x = 0; x < MAP_WIDTH_POINT - 1; x ++) {
        for (int y = 0; y < MAP_HEIGTH_POINT - 1; y ++) {
            if (!([theMap isWallWithPointPosition:CGPointMake(x, y)]||[theMap isWallWithPointPosition:CGPointMake(x + 1, y) ]||[theMap isWallWithPointPosition:CGPointMake(x, y + 1)]||[theMap isWallWithPointPosition:CGPointMake(x + 1, y + 1)])) {
                GLfloat theX = 0, theY = 0;
                theX = PLAYVIEW_X + POINT_LENGTH * (x + 1);
                theY = PLAYVIEW_Y + POINT_LENGTH * (y + 1);
                Beans * theBean = [[Beans alloc] initWithPosition:CGPointMake(theX, theY) withScore:BEAN_SCORE];
                [beans addObject:theBean];
            }
        }
    }
    
    for (int i = 0; i < [beans count]; i++) {
        Beans * theBean = [beans objectAtIndex:i];
        CGPoint thePosition = [theBean sprite].position;
        if ((thePosition.x > 237.5)&&(thePosition.x < 335)) {
            if ((thePosition.y > 140)&& (thePosition.y < 202)) {
                [beans removeObject:theBean];
                i --;
            }
        }
    }
}

- (void)initMaps
{
    theMap = [Maps sharedMap];
}

- (void)initScore
{
    score = [[CCLabelTTF alloc] initWithString:SCORE_INIT_STRING fontName:SCORE_FONTNAME fontSize:SCORE_FONTSIZE];
    score.position = SCORE_POSITION;
}

#pragma mark - 对外接口
#pragma mark - 移动接口

- (void)moveWithDirection:(int)theDirection
{
    if (stateNow == gameBefore) {
        return;
    }
    [player setDirectionAndMove:theDirection];
}

#pragma mark - 玩家开始移动或者暂停移动

- (void)startMoving
{
    if (stateNow == gameBefore) {
        [self gameStart];
        return;
    }
    
    if (stateNow == gameStart) {
        [self gamePause];
        return;
    }

    if (stateNow == gamePause) {
        [self gameResume];
        return;
    }
    
    if (stateNow == gameOver) {
        return;
    }
}



#pragma mark - 私有方法
#pragma mark - 游戏状态

- (void)gameStart
{
    stateNow = gameStart;
    //player
    [player startMove];
    [self schedule:@selector(updatePlayer:) interval:1.0/PLAYER_SPEED];
    //monster
    for (MonsterMan * monster in monsters) {
        [monster startMove];
    }
}

- (void)gamePause
{
    stateNow = gamePause;
    //pause Layer
    thePauseLayer = [PauseLayer node];
    thePauseLayer.delegate = self;
    [self addChild:thePauseLayer z:1 tag:TAG_PAUSELAYER];
    
    //player
    [player pauseMove];
    [self unschedule:@selector(updatePlayer:)];
    
    //monster
    for (MonsterMan * monster in monsters) {
        [monster pauseMove];
    }
}

- (void)gameResume
{
    stateNow = gameStart;
    //Pause Layer
//    thePauseLayer = (PauseLayer *)[self getChildByTag:TAG_PAUSELAYER];
    if (thePauseLayer != nil) {
        [self removeChild:thePauseLayer];
        thePauseLayer = nil;
    }
    //player
    [player resumeMove];
    [self schedule:@selector(updatePlayer:) interval:1.0/PLAYER_SPEED];
    //monster
    for (MonsterMan * monster in monsters) {
        [monster resumeMove];
    }
}

- (void)gameOver
{
    stateNow = gameOver;
    
    thePauseLayer = [[EndLayer alloc] initWithScore:score.string];;
    thePauseLayer.delegate = self;
    [self addChild:thePauseLayer z:1 tag:TAG_ENDLAYER];
    
    //player
    [player pauseMove];
    [self unschedule:@selector(updatePlayer:)];
    
    //monster
    for (MonsterMan * monster in monsters) {
        [monster pauseMove];
    }
    //    CCScene * scene = [GameLayer Scene];
//    [[CCDirector sharedDirector] replaceScene:scene];
}

#pragma mark - 玩家移动时的动作

- (void)updatePlayer:(ccTime)delta
{
    [self crashMonsters];
    [self eatBeans];
}

- (void)crashMonsters
{
    for (MonsterMan * theMonster in monsters) {
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
        if ([player isContainWithRect:[theBean spriteRect]]) {
            [theBean beEaten];
            [player eatBean];
            score.string = [NSString stringWithFormat:@"%d",player.score];
            [beans removeObjectAtIndex:i];
            i --;
        }
    }
    
    if ([beans count] == 0) {
        [self gameOver];
    }
}

#pragma mark - pauseLayer delegate

- (void)resumeGame
{
    [self gameResume];
}


@end
