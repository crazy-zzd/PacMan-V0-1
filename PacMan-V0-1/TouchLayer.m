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
        [self setTouchEnabled:YES];
    }
    return self;
}

-(void) onEnter
{
	[super onEnter];
}

#pragma mark - 触摸反馈事件

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchedPosition = [self locationFromTouches:touches];
    
    nowPosition = touchedPosition;
    
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
    //触摸结束时设定
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