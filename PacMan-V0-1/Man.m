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

- (void)setDirectionAndMove:(int)theDirection
{
//    nextDirection = theDirection;
    NSArray * directions = [theMap moveWithCentrePosition:[self mapPosition] withLengthPoint:length withFirstDirection:nowDirection withSecondDirection:theDirection];
    int numOfDirection = [(NSNumber *)[directions objectAtIndex:0] intValue];
    if (numOfDirection == 0) {
        state = standing;
        return;
    }
    state = moving;
    
    if (numOfDirection == 1) {
        firstPosition = [(NSValue *)[directions objectAtIndex:1] CGPointValue];
        CCSequence * sequence = [CCSequence actions:[self movebyWith:[self mapPosition] and:firstPosition], nil];
        [[self sprite] stopAction:[[self sprite] getActionByTag:TAG_SEQUENCE]];
        [[self sprite] runAction:sequence];
        [sequence setTag:TAG_SEQUENCE];
        return;
    }
    
    if (numOfDirection == 2) {
        firstPosition = [(NSValue *)[directions objectAtIndex:1] CGPointValue];
        secondPosition = [(NSValue *)[directions objectAtIndex:2] CGPointValue];
        CCCallFunc * theSecondeMove = [CCCallFunc actionWithTarget:self selector:@selector(secondMove)];
        CCSequence * sequence = [CCSequence actions:[self movebyWith:[self mapPosition] and:firstPosition], theSecondeMove, nil];
        [[self sprite] stopAction:[[self sprite] getActionByTag:TAG_SEQUENCE]];
        [[self sprite] runAction:sequence];
        [sequence setTag:TAG_SEQUENCE];
        return;
    }
    
    return;
    
}

- (void)move
{
    if (nowDirection != nextDirection) {
        if ([self moveWithDirection:nextDirection]) {
            [self changeSpriteDirection];
            nowDirection = nextDirection;
            return;
        }
    }
    
    [self moveWithDirection:nowDirection];
    
}

- (void)startMove
{
    [self setDirectionAndMove:nowDirection];
}

#pragma mark - 私有方法

- (BOOL)moveWithDirection:(int)theDirection
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
        return NO;
    }
    else{
        state = moving;
        return YES;
    }
    
    
    return NO;
}

- (void)changeSpriteDirection
{
    int theRotation = (nextDirection - nowDirection) * 90;
    if (theRotation < 0) {
        theRotation = theRotation + 360;
    }
    sprite.rotation = [sprite rotation] + theRotation;
}

//- (void)handleWithPosition
//{
//    int theX = [self changeFloat:[self mapPosition].x];
//    int theY = [self changeFloat:[self mapPosition].y];
//    [self setPosition:CGPointMake(theX, theY)];
//}

//- (int)changeFloat:(CGFloat)theNum
//{
//    if (theNum - (int)theNum > 0.5) {
//        return (int)theNum + 1;
//    }
//    return (int)theNum;
//}



//通过两个图坐标，得出CCAction用来移动
- (CCMoveBy *)movebyWith:(CGPoint)theFirstPosition and:(CGPoint)theSecondPosition
{
    CGPoint thePosition = ccpSub(theSecondPosition, theFirstPosition);
    float distence;
    
    if (thePosition.x < 0) {
        distence = - thePosition.x;
        nextDirection = leftDirection;
    }
    if (thePosition.x > 0) {
        distence = thePosition.x;
        nextDirection = rightDirection;
    }
    if (thePosition.y < 0) {
        distence = - thePosition.y;
        nextDirection = downDirection;
    }
    if (thePosition.y > 0) {
        distence = thePosition.y;
        nextDirection = upDirection;
    }
    
    [self changeSpriteDirection];
    nowDirection = nextDirection;
    
    CCMoveBy * move = [CCMoveBy actionWithDuration:distence/MOVING_SPEED position:thePosition];
    return move;
}

//第二次移动，需要修改方向、修改图标方向、增加动作
- (void)secondMove
{
    [self changeSpriteDirection];
    CCSequence * sequence = [CCSequence actions:[self movebyWith:firstPosition and:secondPosition], nil];
    [[self sprite] runAction:sequence];
    [[self sprite] stopAction:[[self sprite] getActionByTag:TAG_SEQUENCE]];
//    [[self sprite] runAction:sequence];
    [sequence setTag:TAG_SEQUENCE];
    return;
}


@end
