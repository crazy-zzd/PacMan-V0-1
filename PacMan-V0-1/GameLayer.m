//
//  GameLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-15.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "GameLayer.h"
#import "TouchLayer.h"
#import "ControlNode.h"
#import "PauseLayer.h"
//#import "MyHeader.h"

#import "CountDownLayer.h"

#import "PlayerMan.h"
#import "MonsterMan.h"
#import "Beans.h"

#import "GameData.h"
#import "Maps.h"

#import "TimeSprite.h"

@implementation GameLayer

@synthesize theTouchLayer;
@synthesize theControNode;

@synthesize mainGameStyle;

#pragma mark - 创建场景
+ (CCScene *)SceneWithStyle:(enum GameStyle)theStyle
{
    //初始化数据类
    GameData * sharedGameData = [GameData sharedData];
    [sharedGameData setStyle:theStyle];
    Maps * sharedMap = [Maps sharedMap];
    [sharedMap handleMap];
    
    CCScene * scene = [CCScene node];
    
    //创建三个层，分别初始化
    GameLayer * gameLayer = [GameLayer node];
    TouchLayer * touchLayer = [TouchLayer node];
    ControlNode * controlNode = [ControlNode node];
    
    //把触摸层和控制层归到游戏层下
    gameLayer.theTouchLayer = touchLayer;
    gameLayer.theControNode = controlNode;
    
    //设置Style
    gameLayer.mainGameStyle = theStyle;
    
    //把三个层添加到场景里
    [scene addChild:gameLayer z:0 tag:TAG_GAMELAYER];
    [scene addChild:touchLayer z:1 tag:TAG_TOUCHLAYER];
    [scene addChild:controlNode z:0 tag:TAG_CONTROLNODE];
    
    //三个层的初始化
    [gameLayer viewDidLoad];
    
    return scene;
}

#pragma mark - 初始化

- (void)viewDidLoad
{
    //设置触摸委托
    theTouchLayer.delegate = self;
    
    theControNode.theDelegate = self;

    //设置数据
    mainGameData = [GameData sharedData];
    [mainGameData setStyle:mainGameStyle];
    
    //添加背景
    [self loadBackGround];
    
    //添加游戏对象
    [self loadPlayer];
    [self loadBeans];
    [self loadMonsters];
    
    //添加分数
    [self loadScore];
    
    //添加并初始化游戏界面元素
    [self loadPauseButton];
    [self loadTimeLine];
    
    //添加倒数界面
    [self loadCountDownLayer];
    
    //测试
//    [self testAnimation];
//    [self draw];
    
}

//添加吃豆人
- (void)loadPlayer
{
    [self addChild:[theControNode.player sprite] z:1];
    [self addChild:theControNode.player];
}

//添加怪兽
- (void)loadMonsters
{
    NSMutableArray * monsters = theControNode.monsters;
    MonsterMan * aMonster;
    for (int i = 0; i < monsters.count; i ++) {
        aMonster = (MonsterMan *)[monsters objectAtIndex:i];
        [self addChild:[aMonster sprite]];
        [self addChild:aMonster];
    }
}

//添加豆子
- (void)loadBeans
{
    NSMutableArray * beans = theControNode.beans;
    Beans * aBean;
    for (int i = 0; i < beans.count; i ++) {
        aBean = (Beans *)[beans objectAtIndex:i];
        [self addChild:[aBean sprite]];
    }
}

//添加并初始化背景图片
- (void)loadBackGround
{
    CCSprite * background = [[CCSprite alloc] initWithFile:mainGameData.mapPngFile];
    background.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [self addChild:background z:0];
}

//添加并初始化暂停按钮
- (void)loadPauseButton
{
    CCMenuItemImage * pauseBtn = [[CCMenuItemImage alloc] initWithNormalImage:mainGameData.pausePngFile selectedImage:mainGameData.pausePngHLFile disabledImage:nil target:theControNode selector:@selector(onPressPause)];
    pauseBtn.position = mainGameData.pausePosition;
    
    CCMenu * btnMenu = [CCMenu menuWithItems:pauseBtn, nil];
    btnMenu.position = CGPointZero;
    btnMenu.enabled = NO;
    [self addChild:btnMenu z:1 tag:TAG_PAUSEBTN];
}

- (void)loadTimeLine
{
    timeLine = [[TimeSprite alloc] init];
    timeLine.position = CGPointMake(193.5 / 2, SCREEN_HEIGHT - 32.5 / 2);
    [self addChild:timeLine];
    
    restTime = TIME_MAX;
//    [self schedule:@selector(updateTimeLine:) interval:0.2];
}

//添加分数
- (void)loadScore
{
    [self addChild:theControNode.score];
}

//添加倒数界面
- (void)loadCountDownLayer
{
    theCountDownLayer = [[CountDownLayer alloc] init];
    [self addChild:theCountDownLayer z:1];
    
//    [self schedule:@selector(updateCountDown:) interval:1.0 repeat:YES delay:0.0];
    [self schedule:@selector(updateCountDown:) interval:1.0];
}

- (void)updateCountDown:(ccTime)delta
{
    if ([theCountDownLayer countNumber]) {
        [theCountDownLayer removeFromParentAndCleanup:YES];
        [theControNode gameStart];
        [self unschedule:@selector(updateCountDown:)];
        CCMenu * pauseBtn = (CCMenu *)[self getChildByTag:TAG_PAUSEBTN];
        pauseBtn.enabled = YES;
        [self schedule:@selector(updateTimeLine:) interval:0.2];
    }
}

- (void)updateTimeLine:(ccTime)delta
{
    if (restTime < 0.3) {
        [self unschedule:@selector(updateTimeLine:)];
        
        [theControNode gameOver];
    }
    restTime = restTime - 0.2;
    [timeLine setTimePercent:restTime / TIME_MAX];
}

#pragma mark - TouchLayerDelegate

- (void)moveWithDirection:(int)theDirection
{
    [theControNode moveWithDirection:theDirection];
}

- (void)playerJump
{
    [theControNode playerJump];
}

#pragma mark - ControlNodeDelegate

- (void)pauseTimeLine
{
    [self unschedule:@selector(updateTimeLine:)];
}

- (void)resumeTimeLine
{
    [self schedule:@selector(updateTimeLine:) interval:0.2];
}

#pragma mark - testMethod
//测试地图
//- (void)draw
//{
//    ccPointSize(175); //设置方块的大小
//    ccDrawColor4B(0,0,255,128);
//    ccDrawPoint(ccp(262.5, 112.5));//位置
//}
//


@end
