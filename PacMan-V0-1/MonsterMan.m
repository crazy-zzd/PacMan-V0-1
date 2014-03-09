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
        
        //测试动画
        [self testAnimation];
    }
    return self;
}

- (void)startMove
{
    [self changeDirection];
    [self schedule:@selector(updateCheckAndMove:)];
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

- (void)updateCheckAndMove:(ccTime)delta
{
    if (state == standing) {
        [self setDirectionAndMove:CCRANDOM_0_1() * 4 + 1];
    }
}

- (void)testAnimation
{
    NSMutableArray * theTestFrames = [NSMutableArray arrayWithCapacity:2];
    for (int i = 1; i <= 2; i ++) {
        NSString * fileName = [NSString stringWithFormat:@"monster-1-down-%d-hd.png",i];
        
        CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:fileName];
        CGSize texSize = texture.contentSize;
        CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
        
        CCSpriteFrame * frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
        [theTestFrames addObject:frame];
    }
    CCAnimation * anim = [CCAnimation animationWithSpriteFrames:theTestFrames delay:0.1f];
    
    CCAnimate * animate = [CCAnimate actionWithAnimation:anim];
    CCRepeatForever * repeat = [CCRepeatForever actionWithAction:animate];
    
    [sprite runAction:repeat];
    
}

- (void)runAnimationWith:(int)theDirection
{
    
}

@end
