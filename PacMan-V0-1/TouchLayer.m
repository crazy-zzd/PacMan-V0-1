//
//  TouchLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "TouchLayer.h"
#import "GameLayer.h"

@implementation TouchLayer

@synthesize delegate;

#pragma mrak - 初始化

-(id)init
{
    if (self = [super init]) {
//        [self loadArrows];
        [self setTouchEnabled:YES];
        
    }
    return self;
}

//- (void)loadArrows
//{
//    CCSprite * upSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
//    upSpr.position = ccp(100, 150);
//    upRect = upSpr.boundingBox;
//    [self addChild:upSpr z:0 tag:tagUp];
//    
//    CCSprite * downSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
//    downSpr.position = ccp(100, 50);
//    downSpr.rotation = 180;
//    downRect = downSpr.boundingBox;
//    [self addChild:downSpr z:0 tag:tagDown];
//    
//    CCSprite * leftSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
//    leftSpr.position = ccp(50, 100);
//    leftSpr.rotation = 270;
//    leftRect = leftSpr.boundingBox;
//    [self addChild:leftSpr z:0 tag:tagLeft];
//    
//    CCSprite * rightSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
//    rightSpr.position = ccp(150, 100);
//    rightSpr.rotation = 90;
//    rightRect = rightSpr.boundingBox;
//    [self addChild:rightSpr z:0 tag:tagRight];
//}

-(void) onEnter
{
	[super onEnter];
}

#pragma mark - 触摸反馈事件

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchedPosition = [self locationFromTouches:touches];
    
    nowPosition = touchedPosition;
    
//    CCSprite * touchedSpr;
//    
//    //当点击上箭头的时候触发
//    if (CGRectContainsPoint(upRect, touchedPoint)) {
//        touchedSpr= (CCSprite *)[self getChildByTag:tagUp];
//        [self sendDirectionSymbole:upDirection];
//    }
//    
//    //当点击下箭头触发
//    if (CGRectContainsPoint(downRect, touchedPoint)) {
//        touchedSpr = (CCSprite *)[self getChildByTag:tagDown];
//        [self sendDirectionSymbole:downDirection];
//    }
//    
//    //当点击左箭头触发
//    if (CGRectContainsPoint(leftRect, touchedPoint)) {
//        touchedSpr = (CCSprite *)[self getChildByTag:tagLeft];
//        [self sendDirectionSymbole:leftDirection];
//    }
//
//    //当点击右箭头触发
//    if (CGRectContainsPoint(rightRect, touchedPoint)) {
//        touchedSpr = (CCSprite *)[self getChildByTag:tagRight];
//        [self sendDirectionSymbole:rightDirection];
//    }
//    
//    touchedSpr.scale = 0.8;
    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchedPosition = [self locationFromTouches:touches];
    CGPoint theChangedPosition = ccpSub(touchedPosition, nowPosition);
    if (fabs(theChangedPosition.x) > fabs(theChangedPosition.y)) {
        if (theChangedPosition.x > MOVE_LIMITED) {
            [self sendDirectionSymbole:rightDirection];
            nowPosition = touchedPosition;
        }
        if (theChangedPosition.x < -MOVE_LIMITED) {
            [self sendDirectionSymbole:leftDirection];
            nowPosition = touchedPosition;
        }
    }
    else{
        if (theChangedPosition.y > MOVE_LIMITED) {
            [self sendDirectionSymbole:upDirection];
            nowPosition = touchedPosition;
        }
        if (theChangedPosition.y < -MOVE_LIMITED){
            [self sendDirectionSymbole:downDirection];
            nowPosition = touchedPosition;
        }
    }
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

//    CCSprite * touchedSpr;
//    for (int i = tagUp; i <= tagRight; i++) {
//        touchedSpr = (CCSprite *)[self getChildByTag:i];
//        touchedSpr.scale = 1;
//    }
    
    //当结束点击的时候方向置空
//    [self sendDirectionSymbole:noDirection];
    
}


-(CGPoint)locationFromTouches:(NSSet *)touches{
    UITouch * touch = touches.anyObject;
    CGPoint touchLocation = [touch locationInView:touch.view];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}


#pragma mark - 给Scene发送消息

- (void)sendDirectionSymbole:(int)theDireciton
{
    [self.delegate moveWithDirection:theDireciton];
}


@end