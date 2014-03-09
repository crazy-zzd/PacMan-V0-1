//
//  StartLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-12-26.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "StartLayer.h"


@implementation StartLayer

+ (CCScene *)Scene
{
    CCScene * scene = [CCScene node];
    
    StartLayer * startLayer = [StartLayer node];
    
    [scene addChild:startLayer];
    
    return scene;
}


- (id)init
{
    self = [super init];
    if (self) {
        
        //天空
        CCSprite * background = [[CCSprite alloc] initWithFile:@"blue-sky.png"];
        background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:background z:0];
    
        //山
        CCSprite * mountains = [[CCSprite alloc] initWithFile:@"mountains.png"];
        mountains.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:mountains z:1];
        
        //云
        clounds = [[NSMutableArray alloc] initWithCapacity:6];
        CGPoint cloudsPosition[6];
        cloudsPosition[0] = CGPointMake(67.5, 33);
        cloudsPosition[1] = CGPointMake(258, 198);
        cloudsPosition[2] = CGPointMake(550, 28);
        cloudsPosition[3] = CGPointMake(800, 131);
        cloudsPosition[4] = CGPointMake(1015, 183);
        cloudsPosition[5] = CGPointMake(1038, 65);
        
        GLfloat cloudsTime[6] = { 1.3, 1.7, 1.0, 1.2, 0.8, 1.4};
        
        CCMoveBy * cloudMove;
        CCRepeatForever * repeatCloud;
        
        CCSprite * tempCloud;
        for (int i = 0; i < 6; i ++) {
            NSString * fileName = [NSString stringWithFormat:@"cloud-%d.png",i + 1];
            tempCloud = [[CCSprite alloc] initWithFile:fileName];
            tempCloud.position = cloudsPosition[i];
            tempCloud.position = CGPointMake(tempCloud.position.x / 2,SCREEN_HEIGHT - tempCloud.position.y / 2);
            cloudMove = [CCMoveBy actionWithDuration:cloudsTime[i] position:CGPointMake(30, 0)];
            repeatCloud = [CCRepeatForever actionWithAction:cloudMove];
            [tempCloud runAction:repeatCloud];
            
            [self addChild:tempCloud z:2];
            [clounds addObject:tempCloud];
        }
        
        //标题
        CCSprite * topic = [[CCSprite alloc] initWithFile:@"topic.png"];
        topic.position = CGPointMake(576.5 / 2, SCREEN_HEIGHT - 95.5 / 2);
        [self addChild:topic z:3];
        
        //太阳后轮
        sunny = [[CCSprite alloc] initWithFile:@"sunny.png"];
        sunny.position = CGPointMake(576.5 / 2, SCREEN_HEIGHT - 336.5 / 2);
        [self addChild:sunny z:3];

        CCRotateBy * rotate = [CCRotateBy actionWithDuration:2 angle:90];
        CCRepeatForever * repeat = [CCRepeatForever actionWithAction:rotate];
        [sunny runAction:repeat];
        
        //太阳
        CCSprite * sun = [[CCSprite alloc] initWithFile:@"sun.png"];
        sun.position = sunny.position;
        [self addChild:sun z:3];
        
        //monsters
        monsters = [[NSMutableArray alloc] initWithCapacity:20];
        CCSprite * tempMonster;
        for (int i = 0; i < 20; i ++) {
            NSString * fileName = [NSString stringWithFormat:@"ghost-%d.png",i % 6 + 1];
            tempMonster = [[CCSprite alloc] initWithFile:fileName];
            tempMonster.position = CGPointMake(22 + i * 28, 18);
            [self addChild:tempMonster z:3];
            [monsters addObject:tempMonster];
        }
        
        //button
        CCMenuItemImage * startButton = [CCMenuItemImage itemWithNormalImage:@"press-start-1.png" selectedImage:@"press-start-2.png" target:self selector:@selector(pressStartButton:)];
        CCMenu *startMenu = [CCMenu menuWithItems:startButton, nil];
        startMenu.position = CGPointMake(576.5 / 2, 52);
        [self addChild:startMenu z:3];
        
        
        theJumpMonster = 0;
        [self schedule:@selector(jumpMonsters:) interval:0.5 repeat:kCCRepeatForever delay:0];
        
        [self schedule:@selector(checkClouds:) interval:0.5 repeat:kCCRepeatForever delay:0];
    }
    
    return self;
}

#pragma mark - private methods
- (void)pressStartButton:(id)sender
{
    CCScene * scene = [GameLayer Scene];
    CCTransitionCrossFade * tran = [CCTransitionFadeBL
                                    transitionWithDuration:0.7 scene:scene];
    [[CCDirector sharedDirector] replaceScene:tran];
}

- (void)jumpMonsters:(ccTime)delta
{
    CCMoveBy * moveUp = [CCMoveBy actionWithDuration:0.5 position:CGPointMake(0, 30)];
    CCMoveBy * moveDown = [CCMoveBy actionWithDuration:0.5 position:CGPointMake(0, -30)];
    CCSequence * move = [CCSequence actions:moveUp,moveDown, nil];
    CCSprite * theMonster = [monsters objectAtIndex:theJumpMonster];
    [theMonster runAction:move];
    theJumpMonster ++;
    theJumpMonster = theJumpMonster % 20;
}

- (void)checkClouds:(ccTime)delta
{
    CCSprite * tempCloud;
    for (int i = 0; i < 6; i ++) {
        tempCloud = [clounds objectAtIndex:i];
        if (tempCloud.position.x > SCREEN_WIDTH + tempCloud.boundingBox.size.width) {
            tempCloud.position = CGPointMake(-tempCloud.boundingBox.size.width/2, tempCloud.position.y);
        }
    }
}

@end
