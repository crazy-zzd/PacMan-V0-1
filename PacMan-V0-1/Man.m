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

@synthesize direction;

- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection
{
    if (self = [self init]) {

        theMap = [Maps sharedMap];
        
        state = standing;

        [self setPointPosition:thePointPosition];
        
        direction = theDrection;
    }
    return self;
}

- (void)move
{
    CGPoint movement;
    switch (direction) {
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
    
    if ([self isCrashedWallWithPointPosition:[self pointPosition] withPosition:[self mapPosition]]) {
        state = standing;
        [self setPosition:oldPosition];
    }
    else{
        state = moving;
    }
    
    
    //    CCLOG(@"x=%f,y=%f",sprite.position.x,sprite.position.y);
    //    CCLOG(@"%f,%f",[self pointPosition].x,[self pointPosition].y);
    
}

#pragma mark - 私有方法

//只通过图坐标实现碰撞，通过中心图坐标计算出四个角的图坐标。
//图坐标实现有问题，给定一个图坐标无法确定这个点是不是有障碍物，因为在分界线上总共有两种可能。可能可以解决的方法：看看是哪个点的坐标
//- (BOOL)isCrashedWallWithPosition:(CGPoint)thePosition
//{
//    BOOL isCrashed;
//
//    return isCrashed;
//}

//通过点坐标和图坐标实现碰撞
- (BOOL)isCrashedWallWithPointPosition:(CGPoint)thePointPosition withPosition:(CGPoint)thePosition
{
    //第一种方法检测是否撞墙
    int thePosX,thePosY;
    thePosX = thePosition.x - (PLAYVIEW_X + POINT_LENGTH * thePointPosition.x + 0.5 * POINT_LENGTH);
    thePosY = thePosition.y - (PLAYVIEW_Y + POINT_LENGTH * thePointPosition.y + 0.5 * POINT_LENGTH);
    BOOL isCrashed = NO;
    if (thePosX > 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y)];
        
    }
    if (thePosX < 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y)];
    }
    if (thePosY > 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x, thePointPosition.y + 1)];
    }
    if (thePosY < 0) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x, thePointPosition.y - 1)];
    }
    if ((thePosX > 0)&&(thePosY > 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y + 1)];
    }
    if ((thePosX < 0)&&(thePosY > 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y + 1)];
    }
    if ((thePosX > 0)&&(thePosY < 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y - 1)];
    }
    if ((thePosX < 0)&&(thePosY < 0)) {
        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y - 1)];
    }
    return isCrashed;
}



@end
