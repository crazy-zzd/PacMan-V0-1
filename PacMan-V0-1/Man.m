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

- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection
{
    if (self = [super init]) {
        
        state = standing;
        
        nowDirection = theDrection;
        nextDirection = theDrection;
    }
    return self;
}

- (void)startMove
{
    [self setDirectionAndMove:nowDirection];
}

- (void)pauseMove
{
    [[self sprite] pauseSchedulerAndActions];
}

- (void)resumeMove
{
    [[self sprite] resumeSchedulerAndActions];
}

- (void)setDirectionAndMove:(int)theDirection
{
    NSArray * directions = [theMap moveWithCentrePosition:[self mapPosition] withLengthPoint:length withFirstDirection:nowDirection withSecondDirection:theDirection];
    int numOfDirection = [(NSNumber *)[directions objectAtIndex:0] intValue];
    
    if (numOfDirection == 0) {
        state = standing;
        return;
    }
    state = moving;

    if (numOfDirection == 1) {
        firstPosition = [(NSValue *)[directions objectAtIndex:1] CGPointValue];
        CCCallFunc * standFunc = [CCCallFunc actionWithTarget:self selector:@selector(standFunc)];
        CCSequence * sequence = [CCSequence actions:[self movebyWith:[self mapPosition] and:firstPosition], standFunc, nil];
        [self runSequence:sequence];
        return;
    }
    
    if (numOfDirection == 2) {
        firstPosition = [(NSValue *)[directions objectAtIndex:1] CGPointValue];
        secondPosition = [(NSValue *)[directions objectAtIndex:2] CGPointValue];
        CCCallFunc * theSecondeMove = [CCCallFunc actionWithTarget:self selector:@selector(secondMove)];
        CCSequence * sequence = [CCSequence actions:[self movebyWith:[self mapPosition] and:firstPosition], theSecondeMove, nil];
        [self runSequence:sequence];
        return;
    }
    
    return;
    
}



#pragma mark - 私有方法

- (void)changeSpriteDirection
{

}

//通过两个图坐标，得出CCAction用来移动
- (CCMoveTo *)movebyWith:(CGPoint)theFirstPosition and:(CGPoint)theSecondPosition
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
    
    
    
    CCMoveTo * move = [CCMoveTo actionWithDuration:distence/moveSpeed position:theSecondPosition];
    return move;
}

//第二次移动，需要修改方向、修改图标方向、增加动作
- (void)secondMove
{
    [self changeSpriteDirection];
    CCCallFunc * standFunc = [CCCallFunc actionWithTarget:self selector:@selector(standFunc)];
    CCSequence * sequence = [CCSequence actions:[self movebyWith:firstPosition and:secondPosition], standFunc,nil];
    [self runSequence:sequence];

    return;
}

- (void)standFunc
{
    state = standing;
}

//运行动作序列
- (void)runSequence:(CCSequence *)theSequence
{
    [[self sprite] runAction:theSequence];
    [[self sprite] stopActionByTag:TAG_SEQUENCE];
    [theSequence setTag:TAG_SEQUENCE];
}

@end
