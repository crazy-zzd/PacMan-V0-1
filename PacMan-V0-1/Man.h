//
//  Man.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"
#import "Things.h"


@class Maps;

@interface Man : Things {
    int nowDirection;
    int nextDirection;
    
    CGPoint firstPosition;
    CGPoint secondPosition;
    
    int state;
    
}

-(id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection;

-(void)startMove;

-(void)setDirectionAndMove:(int)theDirection;


@end
