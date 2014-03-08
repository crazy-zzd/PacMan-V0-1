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
#import "MyHeader.h"

#import "PlayerMan.h"
#import "MonsterMan.h"
#import "Beans.h"

@implementation GameLayer

@synthesize theTouchLayer;
@synthesize theControNode;

#pragma mark - 创建场景
+ (CCScene *)Scene
{
    CCScene * scene = [CCScene node];
    
    //创建三个层，分别初始化
    GameLayer * gameLayer = [GameLayer node];
    TouchLayer * touchLayer = [TouchLayer node];
    ControlNode * controlNode = [ControlNode node];
    
    //把触摸层和控制层归到游戏层下
    gameLayer.theTouchLayer = touchLayer;
    gameLayer.theControNode = controlNode;
    
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

    //添加背景
    [self loadBackGround];
    
    //添加游戏对象
    [self loadPlayer];
    [self loadBeans];
    [self loadMonsters];
    

    
    //添加分数
    [self loadScore];
    
    //添加并初始化游戏界面元素
    [self loadStartButton];
    
    
    //测试
//    [self testAnimation];
//    [self draw];
    
}

//添加吃豆人
- (void)loadPlayer
{
    [self addChild:[theControNode.player sprite]];
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
    CCSprite * background = [[CCSprite alloc] initWithFile:PNG_BACKGROUND];
    background.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [self addChild:background z:0];
}

//添加并初始化开始按钮
- (void)loadStartButton
{
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:26];
    CCMenuItemFont * item = [CCMenuItemFont itemWithString:@"start"	target:theControNode selector:@selector(startMoving)];
    
    CCMenu * menu = [CCMenu menuWithItems:item, nil];
    menu.position = ccp(520, 40);
    [self addChild:menu];
}


//添加分数
- (void)loadScore
{
    [self addChild:theControNode.score];
}


#pragma mark - TouchLayerDelegate

- (void)moveWithDirection:(int)theDirection
{
    [theControNode moveWithDirection:theDirection];
//    NSLog(@"change direction");
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
