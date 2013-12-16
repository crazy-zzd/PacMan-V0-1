//
//  Things.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Things.h"
#import "Maps.h"


@implementation Things

- (id)init
{
    self = [super init];
    if (self) {
        
        length = 1;
        
        theMap = [Maps sharedMap];
    }
    return self;
}
#pragma mark - 接口

#pragma mark - Getter和Setter

- (CCSprite *)sprite
{
    return sprite;
}

- (CGRect)spriteRect
{
    return [sprite boundingBox];
}

- (void)setPointPosition:(CGPoint)thePointPosition withLength:(int)theLength
{
    length = theLength;
    sprite.position = [theMap getCentrePositionFromPointPosition:thePointPosition withLengthPoint:length];
}

- (void)setPosition:(CGPoint)thePosition
{
    sprite.position = thePosition;
}

- (CGPoint)mapPosition
{
    return sprite.position;
}

#pragma mark - 私有方法
@end
