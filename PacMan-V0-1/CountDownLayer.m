//
//  CountDownLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-5.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "CountDownLayer.h"
#import "MyHeader.h"
#import "GameData.h"
#import "SimpleAudioEngine.h"

@implementation CountDownLayer
- (id)init
{
    self = [super init];
    if (self) {
        number1 = [CCSprite spriteWithFile:@"CountDown_1.png"];
        number1.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT /2);
        number2 = [CCSprite spriteWithFile:@"CountDown_2.png"];
        number2.position = number1.position;
        number3 = [CCSprite spriteWithFile:@"CountDown_3.png"];
        number3.position = number2.position;
        
        [self addChild:number3];
        count = 3;
        
        
    }
    return self;
}

- (BOOL)countNumber
{
    if (count == 3) {
        [number3 removeFromParentAndCleanup:YES];
        count --;
        [self addChild:number2];
        
        if ([GameData sharedData].isSound) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"321.mp3"];
        }
        
        return NO;
    }
    if (count == 2) {
        [number2 removeFromParentAndCleanup:YES];
        count --;
        [self addChild:number1];
        
        if ([GameData sharedData].isSound) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"321.mp3"];
        }
        return NO;
    }
    if (count == 1) {
        [number1 removeFromParentAndCleanup:YES];
        
        if ([GameData sharedData].isSound) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"321.mp3"];
        }
        
        if ([GameData sharedData].isMusic) {
            [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        }
        
        return YES;
    }
    count --;
    return NO;
}


@end
