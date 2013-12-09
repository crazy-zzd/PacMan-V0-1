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

- (void)setPointPosition:(CGPoint)thePointPosition
{
    pointPosition = thePointPosition;
    [self changePointPosition];
    
}

- (void)setPosition:(CGPoint)thePosition
{
    sprite.position = thePosition;
    [self changePosition];
}

- (CGPoint)mapPosition
{
    return sprite.position;
}

- (CGPoint)pointPosition
{
    return pointPosition;
}

#pragma mark - 私有方法

//点坐标转变到图坐标
- (void)changePointPosition
{
//    GLfloat x = 0, y = 0;
//    x = PLAYVIEW_X + POINT_LENGTH * pointPosition.x + 1 * POINT_LENGTH;
//    y = PLAYVIEW_Y + POINT_LENGTH * pointPosition.y + 1 * POINT_LENGTH;
//    sprite.position = CGPointMake(x, y);
    sprite.position = [theMap getCentrePositionFromPointPosition:pointPosition withLengthPoint:2];
}

//图坐标到点坐标
- (void)changePosition
{
    int x = 0, y = 0;
    x = (sprite.position.x - PLAYVIEW_X) / POINT_LENGTH;
    y = (sprite.position.y - PLAYVIEW_Y) / POINT_LENGTH;
    pointPosition = CGPointMake(x, y);
}

@end
