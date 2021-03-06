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
#import "SimpleAudioEngine.h"

#import "Man.h"
#import "PlayerMan.h"
#import "MonsterMan.h"
#import "Beans.h"
#import "TimeBeans.h"
#import "DoubleBeans.h"
#import "FruitBeans.h"
#import "Maps.h"
#import "PauseLayer.h"
#import "EndLayer.h"

#import "GameData.h"

@implementation ControlNode

@synthesize player;
@synthesize monsters;
@synthesize beans;
@synthesize score;

#pragma mark - 初始化

- (id)init
{
    if (self = [super init]) {
        
        mainGameData = [GameData sharedData];
        
        [self initMaps];
        
        [self initPlayer];
        
        [self initMonsters];
        
        [self initBeans];
        
        [self initScore];
        
        [self initSounds];
        
        stateNow = gameBefore;
    }
    return self;
}

- (void)initPlayer
{
    player = [[PlayerMan alloc] initWithPointPosition:mainGameData.playerPosition withDirection:mainGameData.playerDirection];
}

- (void)initMonsters
{
    MonsterMan * firstMonster = [[MonsterMan alloc] initWithPointPosition:[mainGameData.monstersPosition[0] CGPointValue] withDirection:[mainGameData.monstersDirection[0] intValue] withIndex:1];
    MonsterMan * secondMonster = [[MonsterMan alloc]initWithPointPosition:[mainGameData.monstersPosition[1] CGPointValue] withDirection:[mainGameData.monstersDirection[1] intValue] withIndex:2];
    MonsterMan * thirdMonster = [[MonsterMan alloc]initWithPointPosition:[mainGameData.monstersPosition[2] CGPointValue] withDirection:[mainGameData.monstersDirection[2] intValue] withIndex:3];
    
    monsters = [[NSMutableArray alloc] init];
    [monsters addObject:firstMonster];
    [monsters addObject:secondMonster];
    [monsters addObject:thirdMonster];
}

- (void)initBeans
{
    BOOL isTimeBean = NO;
    BOOL isDoubleBean = NO;
    int  numberOfFruitBean = 0;
    beans = [[NSMutableArray alloc] init];
    for (int x = 0; x < mainGameData.mapWidthPoint - 1; x ++) {
        for (int y = 0; y < mainGameData.mapHeightPoint- 1; y ++) {
            if (!([theMap isWallWithPointPosition:CGPointMake(x, y)]||[theMap isWallWithPointPosition:CGPointMake(x + 1, y) ]||[theMap isWallWithPointPosition:CGPointMake(x, y + 1)]||[theMap isWallWithPointPosition:CGPointMake(x + 1, y + 1)])) {
                GLfloat theX = 0, theY = 0;
                theX = mainGameData.mapPosition.x + POINT_LENGTH * (x + 1);
                theY = mainGameData.mapPosition.y + POINT_LENGTH * (y + 1);
                Beans * theBean;
                if (round(CCRANDOM_0_1() * 100 + 1) == 1 && !isTimeBean) {
                    isTimeBean = YES;
                    theBean = [[TimeBeans alloc] initWithPosition:CGPointMake(theX, theY) withScore:BEAN_SCORE];
                }
                else if (round(CCRANDOM_0_1() * 90 + 1) == 1 && !isDoubleBean) {
                    isDoubleBean = YES;
                    theBean = [[DoubleBeans alloc] initWithPosition:CGPointMake(theX, theY) withScore:BEAN_SCORE];
                }
                else if (round(CCRANDOM_0_1() * 52 + 1) == 1 && numberOfFruitBean < 2) {
                    numberOfFruitBean ++;
                    theBean = [[FruitBeans alloc] initWithPosition:CGPointMake(theX, theY) withScore:BEAN_SCORE];
                }
                else{
                    theBean = [[Beans alloc] initWithPosition:CGPointMake(theX, theY) withScore:BEAN_SCORE];
                }
                [beans addObject:theBean];
            }
        }
    }
    
    /**
     *  鬼出生的区域去掉所有豆子
     */
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
    score = [[CCLabelTTF alloc] initWithString:SCORE_INIT_STRING fontName:[GameData sharedData].scoreName fontSize:SCORE_FONTSIZE];
    [score setColor:[GameData sharedData].scoreColor];
    score.position = mainGameData.scorePosition;
}

- (void)initSounds
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"eat.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"jump.wav"];
}

#pragma mark - 对外接口
#pragma mark - 移动接口

- (void)moveWithDirection:(int)theDirection
{
//    if (stateNow == gameBefore) {
//        return;
//    }
//    [player setDirectionAndMove:theDirection];
    if (stateNow == gameStart) {
        [player setDirectionAndMove:theDirection];
    }

}

- (void)playerJump
{
    if (stateNow == gameStart) {
        if ([player jump]) {
            if ([GameData sharedData].isSound) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
            }
        }

    }

}

#pragma mark - 玩家开始移动或者暂停移动

- (void)onPressPause
{
//    if (stateNow == gameBefore) {
//        [self gameStart];
//        return;
//    }
    
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
    
    //time line
    [self.theDelegate pauseTimeLine];
    
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
    if (thePauseLayer != nil) {
        [self removeChild:thePauseLayer];
        thePauseLayer = nil;
    }
    
    //time line
    [self.theDelegate resumeTimeLine];
    
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
    
    [self setHightScore:player.score];
    
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

}

- (void)setHightScore:(int)theScore
{
    int oldScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] intValue];
    if (oldScore < theScore) {
        [[NSUserDefaults standardUserDefaults] setObject:@(theScore) forKey:@"highScore"];
    }
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
            
//            if ([GameData sharedData].isMusic) {
//                [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
//            }
//            
//            if ([GameData sharedData].isSound) {
//                [[SimpleAudioEngine sharedEngine] playEffect:@"lose.mp3"];
//            }
            [self playSoundWith:NO];
            
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
            [player eatBean:theBean];
            

            
            if ([GameData sharedData].isSound) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"eat.wav"];
            }

            
            score.string = [NSString stringWithFormat:@"%d",player.score];
            [beans removeObjectAtIndex:i];
            i --;
        }
    }
    
    if ([beans count] == 0) {
        
//        if ([GameData sharedData].isMusic) {
//            [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
//        }
//        
//        if ([GameData sharedData].isSound) {
//            [[SimpleAudioEngine sharedEngine] playEffect:@"win.mp3"];
//        }
        [self playSoundWith:YES];
        
        [self gameOver];
    }
}

- (void)playSoundWith:(BOOL)isWin
{
    ALuint soundId;
    
    if ([GameData sharedData].isMusic) {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }
    if (isWin) {
        if ([GameData sharedData].isSound) {
            soundId = [[SimpleAudioEngine sharedEngine] playEffect:@"win.mp3"];
        }
    }
    else{
        if ([GameData sharedData].isSound) {
            soundId = [[SimpleAudioEngine sharedEngine] playEffect:@"lose.mp3"];
        }
    }
    
    [GameData sharedData].soundId = soundId;
}

#pragma mark - pauseLayer delegate

- (void)resumeGame
{
    [self gameResume];
}


@end
