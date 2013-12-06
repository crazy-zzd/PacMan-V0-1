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

- (id)init
{
    if (self = [super init]) {
        direction = leftDirection;
        sprite = [[CCSprite alloc] initWithFile:PNG_MONSTER];
        [self setPointPosition:CGPointMake(5, 5)];
        ;
        
    }
    return self;
}

- (void)move
{
    [super move];
    if (state == standing) {
        [self changeDirection];
    }
    if (state == moving) {
        
    }
}

//- (void)move
//{
//    [self setPosition:[self mapPosition]];
//    if ([self isCrashedWallWithPointPosition:[self pointPosition] withPosition:[self mapPosition]]) {
//        [sprite stopAllActions];
//    }
//    
//    if ([sprite numberOfRunningActions] != 0) {
//        return;
//    }
//
//    int theDirection;
//    theDirection = arc4random() % 4 + 1;
//    switch (theDirection) {
//        case upDirection:
//            [sprite runAction:moveUp];
//            ;
//            break;
//
//        case downDirection:
//            [sprite runAction:moveDown];
//            ;
//            break;
//
//        case leftDirection:
//            [sprite runAction:moveLeft];
//            ;
//            break;
//
//        case rightDirection:
//            [sprite runAction:moveRight];
//            ;
//            break;
//        default:
//            break;
//   } 
//
//}

//- (void)moveWithDirection:(int)theDirection
//{
//    if (direction == theDirection) {
//        return;
//    }
//    
//    direction = theDirection;
//    
//    //    [sprite stopAllActions];
//    if (sprite.numberOfRunningActions == 0) {
//        [sprite runAction:moveRight];
//        return;
//    }
//    
//    switch (direction) {
//        case upDirection:
//            [sprite runAction:moveUp];
//            ;
//            break;
//            
//        case downDirection:
//            [sprite runAction:moveDown];
//            ;
//            break;
//            
//        case leftDirection:
//            [sprite runAction:moveLeft];
//            ;
//            break;
//            
//        case rightDirection:
//            [sprite runAction:moveRight];
//            ;
//            break;
//        default:
//            break;
//   } 
//    
//    
//    
//}

//- (void)pauseActions
//{
//    [sprite stopAllActions];
//}


#pragma mark - 私有方法

- (void)changeDirection
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeDirection) object:self];
    direction = CCRANDOM_0_1() * 4 + 1;
    GLfloat theTime;
    theTime = CCRANDOM_0_1() + 0.5;
    CCLOG(@"%f,%d",theTime,direction);
    [self performSelector:@selector(changeDirection) withObject:self afterDelay:theTime];
    
}

//通过点坐标和图坐标实现碰撞
//- (BOOL)isCrashedWallWithPointPosition:(CGPoint)thePointPosition withPosition:(CGPoint)thePosition
//{
//    //第一种方法检测是否撞墙
//    int thePosX,thePosY;
//    thePosX = thePosition.x - (PLAYVIEW_X + POINT_LENGTH * thePointPosition.x + 0.5 * POINT_LENGTH);
//    thePosY = thePosition.y - (PLAYVIEW_Y + POINT_LENGTH * thePointPosition.y + 0.5 * POINT_LENGTH);
//    BOOL isCrashed = NO;
//    if (thePosX > 0) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y)];
//        
//    }
//    if (thePosX < 0) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y)];
//    }
//    if (thePosY > 0) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x, thePointPosition.y + 1)];
//    }
//    if (thePosY < 0) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x, thePointPosition.y - 1)];
//    }
//    if ((thePosX > 0)&&(thePosY > 0)) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y + 1)];
//    }
//    if ((thePosX < 0)&&(thePosY > 0)) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y + 1)];
//    }
//    if ((thePosX > 0)&&(thePosY < 0)) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x + 1, thePointPosition.y - 1)];
//    }
//    if ((thePosX < 0)&&(thePosY < 0)) {
//        isCrashed = isCrashed || [theMap isWallWithPointPosition:ccp(thePointPosition.x - 1, thePointPosition.y - 1)];
//    }
//    return isCrashed;
//}

@end
