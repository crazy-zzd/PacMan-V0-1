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

//初始化Man
- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection
{
    if (self = [super init]) {
        
        state = standing;
        
        nowDirection = theDrection;

        CCMoveBy * theMove = [CCMoveBy actionWithDuration:1 position:CGPointMake(0, 60)];
        moveUp = [CCRepeatForever actionWithAction:theMove];
        theMove = [CCMoveBy actionWithDuration:1 position:CGPointMake(0, -60)];
        moveDown = [CCRepeatForever actionWithAction:theMove];
        theMove = [CCMoveBy actionWithDuration:1 position:CGPointMake(-60, 0)];
        moveLeft = [CCRepeatForever actionWithAction:theMove];
        theMove = [CCMoveBy actionWithDuration:1 position:CGPointMake(60, 0)];
        moveRight = [CCRepeatForever actionWithAction:theMove];
    }
    return self;
}

//开始移动
- (void)startMove
{
    [self schedule:@selector(updateCheckPosition:)];
    [self calDestinationsWithDirection:nowDirection];
    [self moveWithNowDirection];
}

//暂停移动
- (void)pauseMove
{
    [[self sprite] pauseSchedulerAndActions];
    [self pauseSchedulerAndActions];
}

//继续移动
- (void)resumeMove
{
    [[self sprite] resumeSchedulerAndActions];
    [self resumeSchedulerAndActions];
}

//设置移动方向
- (void)setDirection:(int)theDirection
{
    [self calDestinationsWithDirection:theDirection];
}




#pragma mark - 第一条线程，通过外界的方向改变接口触发
//设置移动方向后计算目的地
- (void)calDestinationsWithDirection:(int)theDirection
{
    NSLog(@"before cal");
    NSArray * directions = [theMap moveWithCentrePosition:[self mapPosition] withLengthPoint:length withFirstDirection:nowDirection withSecondDirection:theDirection];
    int numOfDirection = [(NSNumber *)[directions objectAtIndex:0] intValue];
    
    if (numOfDirection == 1) {
        secondPosition = firstPosition = [(NSValue *)[directions objectAtIndex:1] CGPointValue];
        [self moveWithNowDirection];
        NSLog(@"1 cal");
        return;
    }
    
    
    if (numOfDirection == 2) {
        firstPosition = [(NSValue *)[directions objectAtIndex:1] CGPointValue];
        secondPosition = [(NSValue *)[directions objectAtIndex:2] CGPointValue];
        
        return;
    }
    
    return;
}

#pragma mark - 第二条线程，时刻检测Man的位置
- (void)updateCheckPosition:(ccTime)delta
{
    CGPoint theSpritePosition = [self mapPosition];
    if (![self isPoint:theSpritePosition equalToPoint:firstPosition]) {
        //如果没有到达第一目的地，就继续
        return;
    }
    if ([self isPoint:theSpritePosition equalToPoint:secondPosition]) {
        //如果同时到达了第一第二目的地，就停止运动
        [self stopActionMove];
        return;
    }
    else{
        //如果到达了第一目的地没有到达第二目的地，就转换方向，向第二目的地运动
        firstPosition = secondPosition;
        [self changeDirectionWithFirstPosition];
        [self moveWithNowDirection];
    }
}

#pragma mark - 私有方法
//停止当前的移动
- (void)stopActionMove
{
    [[self sprite] stopAction:[[self sprite] getActionByTag:TAG_MOVETO]];
    state = standing;
}

//调整方向
- (void)changeDirectionWithFirstPosition
{
    CGPoint thePosition = ccpSub(firstPosition, [self mapPosition]);
    int nextDirection;
    if (thePosition.x < 0) {
        nextDirection = leftDirection;
    }
    if (thePosition.x > 0) {
        nextDirection = rightDirection;
    }
    if (thePosition.y < 0) {
        nextDirection = downDirection;
    }
    if (thePosition.y > 0) {
        nextDirection = upDirection;
    }
    
    [self changeSpriteDirectionWith:nextDirection];
    nowDirection = nextDirection;
    
}

//
- (void)moveWithNowDirection
{
    CGPoint thePosition = ccpSub([self mapPosition], firstPosition);
    int distance = abs(thePosition.x) + abs(thePosition.y);
    CCMoveTo * moveTo = [CCMoveTo actionWithDuration:distance / (float)MOVING_SPEED position:firstPosition];
    [[self sprite] stopActionByTag:TAG_MOVETO];
    [[self sprite] runAction:moveTo];
    moveTo.tag = TAG_MOVETO;
    
//    CCRepeatForever * theMove;
//    switch (nowDirection) {
//        case upDirection:
//            theMove = moveUp;
//            break;
//        case downDirection:
//            theMove = moveDown;
//            break;
//        case leftDirection:
//            theMove = moveLeft;
//            break;
//        case rightDirection:
//            theMove = moveRight;
//            break;
//        default:
//            break;
//    }
//    [[self sprite] stopActionByTag:TAG_MOVEBY];
//    [[self sprite] runAction:theMove];
//    theMove.tag = TAG_MOVEBY;
}

//动画调整方向
- (void)changeSpriteDirectionWith:(int)theDirection
{
    int theRotation = (theDirection - nowDirection) * 90;
    if (theRotation < 0) {
        theRotation = theRotation + 360;
    }
    sprite.rotation = [sprite rotation] + theRotation;
}

- (BOOL)isPoint:(CGPoint)theFirstPoint equalToPoint:(CGPoint)theSecondPoint
{
    CGPoint subPoint = ccpSub(theFirstPoint, theSecondPoint);
    if ((abs(subPoint.x) < 2)&&(abs(subPoint.y) < 2)) {
        return YES;
    }
    return NO;
}

//通过两个图坐标，得出CCAction用来移动
//- (CCMoveBy *)movebyWith:(CGPoint)theFirstPosition and:(CGPoint)theSecondPosition
//{
//    CGPoint thePosition = ccpSub(theSecondPosition, theFirstPosition);
//    float distence;
//    int nextDirection;
//    if (thePosition.x < 0) {
//        distence = - thePosition.x;
//        nextDirection = leftDirection;
//    }
//    if (thePosition.x > 0) {
//        distence = thePosition.x;
//        nextDirection = rightDirection;
//    }
//    if (thePosition.y < 0) {
//        distence = - thePosition.y;
//        nextDirection = downDirection;
//    }
//    if (thePosition.y > 0) {
//        distence = thePosition.y;
//        nextDirection = upDirection;
//    }
//    
//    [self changeSpriteDirection];
//    nowDirection = nextDirection;
//    
//    CCMoveBy * move = [CCMoveBy actionWithDuration:distence/MOVING_SPEED position:thePosition];
//    return move;
//}
//
////第二次移动，需要修改方向、修改图标方向、增加动作
//- (void)secondMove
//{
//    [self changeSpriteDirection];
//    CCSequence * sequence = [CCSequence actions:[self movebyWith:firstPosition and:secondPosition], nil];
//    [self runSequence:sequence];
//    return;
//}

//#pragma mark - 移动
//- (void)runSequence:(CCSequence * )theSequence
//{
//    [[self sprite] runAction:theSequence];
//    [[self sprite] stopAction:[[self sprite] getActionByTag:TAG_SEQUENCE]];
//    [theSequence setTag:TAG_SEQUENCE];
//}

@end
