//
//  Man.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Man.h"
#import "Maps.h"


@implementation Man

//@synthesize nowDirection;

- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection
{
    if (self = [super init]) {
        
        state = standing;
        
        nowDirection = theDrection;
        nextDirection = theDrection;
    }
    return self;
}

- (void)setDirection:(int)theDirection
{
    nextDirection = theDirection;
}

- (void)move
{
    if (nowDirection != nextDirection) {
        [self moveWithDirection:nextDirection];
        if (state == moving) {
            nowDirection = nextDirection;
            return;
        }
    }
    
    [self moveWithDirection:nowDirection];
    
}

#pragma mark - 私有方法

- (void)moveWithDirection:(int)theDirection
{
    CGPoint movement;
    switch (theDirection) {
        case upDirection:
            movement = UP_MOVEMENT;
            break;
        case downDirection:
            movement = DOWN_MOVEMENT;
            break;
        case leftDirection:
            movement = LEFT_MOVEMENT;
            break;
        case rightDirection:
            movement = RIGHT_MOVEMENT;
            break;
        default:
            break;
    }
    CGPoint oldPosition = [self mapPosition];
    CGPoint newPosition = ccpAdd([self mapPosition], movement);
    [self setPosition:newPosition];
    
    if ([theMap isCrashedWallWithCentrePosition:[self mapPosition] withLengthPoint:length withDirection:theDirection]) {
        state = standing;
        [self setPosition:oldPosition];
    }
    else{
        state = moving;
    }

}

@end
