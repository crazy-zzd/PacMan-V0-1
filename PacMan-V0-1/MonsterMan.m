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

- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection withIndex:(int)index
{
    if (self = [super initWithPointPosition:thePointPosition withDirection:theDrection]) {
        
        NSString * fileName = [NSString stringWithFormat:@"monster-%d-right-1.png",index];
        
        indexOfMonster = index;
        
        moveSpeed = MONSTERS_SPEED;
        
        sprite = [[CCSprite alloc] initWithFile:fileName];
        
        [self setPointPosition:thePointPosition withLength:2];
        
        [self initAnimations];
        
        [self runAnimationWith:nowDirection];

    }
    return self;
}

- (void)startMove
{
    [self changeDirection];
    [self schedule:@selector(updateCheckAndMove:)];
}

- (void)pauseMove
{
    [super pauseMove];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeDirection) object:self];
}

- (void)resumeMove
{
    [super resumeMove];
    [self changeDirection];
}

#pragma mark - 私有方法

- (void)initAnimations
{
    animationArray = [[NSMutableArray alloc] init];
    NSArray * directionArray = [NSArray arrayWithObjects:@"up", @"right", @"down", @"left", nil];
    
    for (int i = upDirection; i <= leftDirection; i ++) {
        NSMutableArray * theTestFrames = [NSMutableArray arrayWithCapacity:2];
        for (int j = 1; j <= 2; j ++) {
            NSString * fileName = [NSString stringWithFormat:@"monster-%d-%@-%d-hd.png", indexOfMonster, [directionArray objectAtIndex:i - 1], j];
            
            CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:fileName];
            CGSize texSize = texture.contentSize;
            CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
            
            CCSpriteFrame * frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
            [theTestFrames addObject:frame];
        }
        
        CCAnimation * anim = [CCAnimation animationWithSpriteFrames:theTestFrames delay:0.2f];
        
        CCAnimate * animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever * repeat = [CCRepeatForever actionWithAction:animate];
        [animationArray addObject:repeat];
    }
}

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
        NSString * fileName = [NSString stringWithFormat:@"monster-%d-down-%d-hd.png", indexOfMonster,i];
        
        CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:fileName];
        CGSize texSize = texture.contentSize;
        CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
        
        CCSpriteFrame * frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
        [theTestFrames addObject:frame];
    }
    CCAnimation * anim = [CCAnimation animationWithSpriteFrames:theTestFrames delay:0.3f];
    
    CCAnimate * animate = [CCAnimate actionWithAnimation:anim];
    CCRepeatForever * repeat = [CCRepeatForever actionWithAction:animate];
    
    [sprite runAction:repeat];
    
}

- (void)runAnimationWith:(int)theDirection
{
    [[self sprite] stopActionByTag:TAG_ANIMATION_REPEAT];
    CCRepeatForever * animation = (CCRepeatForever *)[animationArray objectAtIndex:theDirection - 1];
    animation.tag = TAG_ANIMATION_REPEAT;
    [[self sprite] runAction:animation];
}

- (void)changeSpriteDirection
{
    [self runAnimationWith:nextDirection];
}

@end
