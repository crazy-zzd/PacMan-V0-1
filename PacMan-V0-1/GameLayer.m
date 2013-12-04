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
    
    GameLayer * gameLayer = [GameLayer node];
    TouchLayer * touchLayer = [TouchLayer node];
    ControlNode * controlNode = [ControlNode node];
    
    gameLayer.theTouchLayer = touchLayer;
    gameLayer.theControNode = controlNode;
    
    [scene addChild:gameLayer z:0 tag:TAG_GAMELAYER];
    [scene addChild:touchLayer z:1 tag:TAG_TOUCHLAYER];
    [scene addChild:controlNode z:0 tag:TAG_CONTROLNODE];
    
    [gameLayer viewDidLoad];
    
    return scene;
}

#pragma mark - 初始化

- (void)viewDidLoad
{
    theTouchLayer.delegate = self;
    
    [self loadPlayer];
    [self loadBeans];
//    [self loadMonsters];
    [self loadStartButton];
    [self draw];                                  
}

- (void)draw
{
    ccPointSize(175); //设置方块的大小
    ccDrawColor4B(0,0,255,128);
    ccDrawPoint(ccp(262.5, 112.5));//位置
}

- (void)loadPlayer
{
    [self addChild:theControNode.player.sprite];
}

- (void)loadMonsters
{
    NSMutableArray * monsters = theControNode.monsters;
    MonsterMan * aMonster;
    for (int i = 0; i < monsters.count; i ++) {
        aMonster = (MonsterMan *)[monsters objectAtIndex:i];
        [self addChild:aMonster.sprite];
    }
}

- (void)loadBeans
{
    NSMutableArray * beans = theControNode.beans;
    Beans * aBean;
    for (int i = 0; i < beans.count; i ++) {
        aBean = (Beans *)[beans objectAtIndex:i];
        [self addChild:aBean.sprite];
    }
}

- (void)loadStartButton
{
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:26];
    CCMenuItemFont * item = [CCMenuItemFont itemWithString:@"start"	target:theControNode selector:@selector(startMoving)];
    
    CCMenu * menu = [CCMenu menuWithItems:item, nil];
    menu.position = ccp(300, 250);
    [self addChild:menu];
}


#pragma mark - TouchLayerDelegate

- (void)moveWithDirection:(int)theDirection
{
    [theControNode moveWithDirection:theDirection];
}




@end
