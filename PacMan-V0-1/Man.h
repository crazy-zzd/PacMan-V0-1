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

#define PLAYER_MOVEMENT 1
#define PLAYER_MOVEUP CGPointMake(0, PLAYER_MOVEMENT)
#define PLAYER_MOVEDOWN CGPointMake(0, -PLAYER_MOVEMENT)
#define PLAYER_MOVELEFT CGPointMake(-PLAYER_MOVEMENT, 0)
#define PLAYER_MOVERIGHT CGPointMake(PLAYER_MOVEMENT, 0)


#define TIME_MOVE 2

@class Maps;

@interface Man : Things {
    int direction;
    
    int state;
    
    
    CCMoveBy * moveLeft;
    CCMoveBy * moveRight;
    CCMoveBy * moveUp;
    CCMoveBy * moveDown;
    
    Maps * theMap;
    
}

@property int direction;

-(void)move;



@end
