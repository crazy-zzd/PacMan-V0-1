//
//  ControlLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-8.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "ControlLayer.h"


@implementation ControlLayer

-(id)init
{
    if (self = [super init]) {
        
        
        CCSprite * upSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
        upSpr.position = ccp(100, 150);
        upRect = upSpr.boundingBox;
        [self addChild:upSpr z:0 tag:tagUp];
        
        CCSprite * downSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
        downSpr.position = ccp(100, 50);
        downSpr.rotation = 180;
        downRect = downSpr.boundingBox;
        [self addChild:downSpr z:0 tag:tagDown];
        
        CCSprite * leftSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
        leftSpr.position = ccp(50, 100);
        leftSpr.rotation = 270;
        leftRect = leftSpr.boundingBox;
        [self addChild:leftSpr z:0 tag:tagLeft];
        
        CCSprite * rightSpr = [[CCSprite alloc] initWithFile:@"Arrow.png"];
        rightSpr.position = ccp(150, 100);
        rightSpr.rotation = 90;
        rightRect = rightSpr.boundingBox;
        [self addChild:rightSpr z:0 tag:tagRight];
        
        
//        [self schedule:<#(SEL)#>]
        
        [self setTouchEnabled:YES];
        
    }
    return self;
}
-(void) onEnter
{
	[super onEnter];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchedPoint = [self locationFromTouches:touches];
    CCSprite * touchedSpr;
    if (CGRectContainsPoint(upRect, touchedPoint)) {
        touchedSpr= (CCSprite *)[self getChildByTag:tagUp];
        
    }
    if (CGRectContainsPoint(downRect, touchedPoint)) {
        touchedSpr = (CCSprite *)[self getChildByTag:tagDown];
    
    }
    if (CGRectContainsPoint(leftRect, touchedPoint)) {
        touchedSpr = (CCSprite *)[self getChildByTag:tagLeft];
    
    }
    if (CGRectContainsPoint(rightRect, touchedPoint)) {
        touchedSpr = (CCSprite *)[self getChildByTag:tagRight];
    
    }
    
    touchedSpr.scale = 0.8;

}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{

}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CCSprite * touchedSpr;
    for (int i = tagUp; i <= tagRight; i++) {
        touchedSpr = (CCSprite *)[self getChildByTag:i];
        touchedSpr.scale = 1;
    }
    
}


-(CGPoint)locationFromTouches:(NSSet *)touches{
    UITouch * touch = touches.anyObject;
    CGPoint touchLocation = [touch locationInView:touch.view];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

@end
