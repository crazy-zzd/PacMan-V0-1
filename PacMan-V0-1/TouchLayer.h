//
//  TouchLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"

#import "TouchLayerDelegate.h"

#define MOVE_LIMITED 25

#define JUMP_TIME 0.15
#define JUMP_DISTANCE 10

@class GameLayer;

@interface TouchLayer : CCLayer {
    CGPoint nowPosition;
    
    NSDate * beginTime;
    CGPoint beginPosition;
}

@property id<TouchLayerDelegate> delegate;

-(void)sendDirectionSymbole:(int)theDireciton;

-(void)sendJumpSymble;

//-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


-(CGPoint)locationFromTouches:(NSSet *)touches;

@end
