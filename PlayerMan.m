//
//  PlayerMan.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "PlayerMan.h"
#import "Maps.h"


@implementation PlayerMan

- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection
{
    if (self = [super initWithPointPosition:thePointPosition withDirection:theDrection]) {
        
        sprite = [[CCSprite alloc] initWithFile:PNG_PACMAN];
        
        //setPointPosition必须在sprite设置过以后才能正常工作
        [self setPointPosition:thePointPosition withLength:2];
        
        //测试动画
        [self testAnimation];
        
        score = 0;
    }
    return self;
}


- (void)eatBean
{
    score ++;
}

- (int)score
{
    return score;
}

- (BOOL)isCrashedWithRect:(CGRect)theRect
{
    if (CGRectIntersectsRect(theRect, sprite.boundingBox)) {
        return YES;
    }
    return NO;
}

- (BOOL)isContainWithRect:(CGRect)theRect
{
    if ((CGRectContainsRect(sprite.boundingBox, theRect))) {
        return YES;
    }
    return NO;
}


#pragma mark - private methods
- (void)testAnimation
{
    NSMutableArray * theTestFrames = [NSMutableArray arrayWithCapacity:4];
    for (int i = 1; i <= 4; i ++) {
        NSString * fileName = [NSString stringWithFormat:@"pac-man-%d.png",i];
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




@end
