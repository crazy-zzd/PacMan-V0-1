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




@end
