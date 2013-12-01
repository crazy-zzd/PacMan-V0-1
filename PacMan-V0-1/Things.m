//
//  Things.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Things.h"


@implementation Things

@synthesize sprite;

#pragma mark - 接口

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

- (void)changePointPosition
{
    int x = 0, y = 0;
    x = PLAYVIEW_X + POINT_LENGTH * pointPosition.x;
    y = PLAYVIEW_Y + POINT_LENGTH * pointPosition.y;
    sprite.position = CGPointMake(x, y);
}

- (void)changePosition
{
    int x = 0, y = 0;
    x = (sprite.position.x - PLAYVIEW_X) / POINT_LENGTH;
    y = (sprite.position.y - PLAYVIEW_Y) / POINT_LENGTH;
    pointPosition = CGPointMake(x, y);
}

@end
