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

#define MOVEMENT 100
#define UP_MOVEMENT CGPointMake(0 ,MOVEMENT)
#define DOWN_MOVEMENT CGPointMake(0 ,-MOVEMENT)
#define LEFT_MOVEMENT CGPointMake(-MOVEMENT ,0)
#define RIGHT_MOVEMENT CGPointMake(+MOVEMENT ,0)

#define TIME_MOVE 1

@interface Man : Things {
    int direction;
    
    CCMoveBy * moveLeft;
    CCMoveBy * moveRight;
    CCMoveBy * moveUp;
    CCMoveBy * moveDown;
    
}

@property int direction;


-(void)updateSpr;




@end
