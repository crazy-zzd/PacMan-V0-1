//
//  PauseLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-12-27.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "PauseLayer.h"
#import "MyHeader.h"
#import "GameLayer.h"
#import "StartLayer.h"

@implementation PauseLayer

@synthesize delegate;

+ (CCScene * )Scene
{
    CCScene * scene = [CCScene node];
    PauseLayer * pauseLayer = [PauseLayer node];
    [scene addChild:pauseLayer];
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        CCSprite * background = [[CCSprite alloc] initWithFile:@"pause-background.png"];
        background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:background];
        
        CCMenuItemImage * restartItem = [CCMenuItemImage itemWithNormalImage:@"pause-replay-still.png" selectedImage:@"pause-replay-touched.png" target:self selector:@selector(onPressRestart:)];
        restartItem.position = CGPointMake(180, 165);
        
        CCMenuItemImage * menuItem = [CCMenuItemImage itemWithNormalImage:@"pause-menu-still.png" selectedImage:@"pause-menu-touched.png" target:self selector:@selector(onPressMenu:)];
        menuItem.position = CGPointMake(SCREEN_WIDTH / 2, 165);
        
        CCMenuItemImage * nextItem = [CCMenuItemImage itemWithNormalImage:@"pause-next-still.png" selectedImage:@"pause-next-touched.png" target:self selector:@selector(onPressNext:)];
        nextItem.position = CGPointMake(SCREEN_WIDTH - 180, 165);
        
        CCMenu * menu = [CCMenu menuWithItems:restartItem, menuItem, nextItem, nil];
        menu.position = CGPointMake(0, 0);
        [self addChild:menu];
        
    }
    return self;
}

- (IBAction)onPressRestart:(id)sender
{
    CCScene * scene = [GameLayer Scene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (IBAction)onPressMenu:(id)sender
{
    CCScene * scene = [StartLayer Scene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (IBAction)onPressNext:(id)sender
{
    [self.delegate resumeGame];
}

@end
