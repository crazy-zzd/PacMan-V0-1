//
//  EndLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-3-9.
//  Copyright 2014年 朱 俊健. All rights reserved.
//

#import "EndLayer.h"

#import "GameData.h"

@implementation EndLayer

- (id)initWithScore:(NSString *)theScore
{
    score = theScore;
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {

        
    }
    return self;
}

- (void)viewDidLoad
{
    //背景
    CCSprite * background = [[CCSprite alloc] initWithFile:@"end-background.png"];
    background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    [self addChild:background];
    
    //标题：你的分数
    CCSprite * yourscore = [[CCSprite alloc] initWithFile:@"end-yourscore.png"];
    yourscore.position = CGPointMake(SCREEN_WIDTH / 2, 230);
    [self addChild:yourscore];

    //分数
    CCLabelTTF * theScoreLabel = [[CCLabelTTF alloc] initWithString:score fontName:[GameData sharedData].scoreName fontSize:72];
    theScoreLabel.position = CGPointMake(SCREEN_WIDTH / 2, 175);
    [self addChild:theScoreLabel];


    //重新开始
    CCMenuItemImage * restartItem = [CCMenuItemImage itemWithNormalImage:@"end-replay-still.png" selectedImage:@"end-replay-touched.png" target:self selector:@selector(onPressRestart:)];
    restartItem.position = CGPointMake(230, 100);
    
    
    //回到主界面
    CCMenuItemImage * menuItem = [CCMenuItemImage itemWithNormalImage:@"end-menu-still.png" selectedImage:@"end-menu-touched.png" target:self selector:@selector(onPressMenu:)];
    menuItem.position = CGPointMake(350, 100);
    

    //按钮响应
    CCMenu * menu = [CCMenu menuWithItems:restartItem, menuItem, nil];
    menu.position = CGPointMake(0, 0);
    [self addChild:menu];
}

@end
