//
//  MonsterMan.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "MonsterMan.h"
#import "Maps.h"


@implementation MonsterMan

- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection
{
    if (self = [super initWithPointPosition:thePointPosition withDirection:theDrection]) {
        
        sprite = [[CCSprite alloc] initWithFile:PNG_MONSTER];
        
        [self setPointPosition:thePointPosition withLength:2];
    }
    return self;
}

- (void)startMove
{
    [self changeDirection];
}

#pragma mark - 私有方法
//未使用
- (void)changeDirection
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeDirection) object:self];
    [self setDirectionAndMove:CCRANDOM_0_1() * 4 + 1];
    GLfloat theTime;
    theTime = CCRANDOM_0_1() * (MONSTER_CHANGEDIRECTION_MOSTTIME - MONSTER_CHANGEDIRECTION_LEASTTIME) + MONSTER_CHANGEDIRECTION_LEASTTIME;
    [self performSelector:@selector(changeDirection) withObject:self afterDelay:theTime];
    
}

@end
