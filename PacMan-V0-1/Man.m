//
//  Man.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Man.h"

@implementation Man

@synthesize direction;

- (id)init 
{
    if (self = [super init]) {
        moveUp = [CCMoveBy actionWithDuration:TIME_MOVE position:UP_MOVEMENT];
        moveDown = [CCMoveBy actionWithDuration:TIME_MOVE position:DOWN_MOVEMENT];
        moveLeft = [CCMoveBy actionWithDuration:TIME_MOVE position:LEFT_MOVEMENT];
        moveRight = [CCMoveBy actionWithDuration:TIME_MOVE position:RIGHT_MOVEMENT];
    }
    return self;
}



- (void)updateSpr
{
    if (sprite.numberOfRunningActions == 0) {
        CCMoveTo * tempMove = [CCMoveTo actionWithDuration:0.05 position:[self mapPosition]];
        [sprite runAction:tempMove];
    }
}


@end
