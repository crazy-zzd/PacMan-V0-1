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
    
    float moveSpeed;
    
}

-(id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection;

//开始移动
-(void)startMove;

//暂停移动
-(void)pauseMove;

//恢复移动
-(void)resumeMove;

//改变方向
-(void)setDirectionAndMove:(int)theDirection;


@end
