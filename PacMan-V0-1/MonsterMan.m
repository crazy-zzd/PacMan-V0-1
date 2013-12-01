//
//  MonsterMan.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "MonsterMan.h"


@implementation MonsterMan

- (id)init
{
    if (self = [super init]) {
        direction = leftDirection;
        sprite = [[CCSprite alloc] initWithFile:@"Green.png"];
        [self setPointPosition:CGPointMake(5, 5)];
        ;
    }
    return self;
}


- (void)moveWithDirection:(int)theDirection
{
    if (direction == theDirection) {
        return;
    }
    
    direction = theDirection;
    
    //    [sprite stopAllActions];
    if (sprite.numberOfRunningActions == 0) {
        [sprite runAction:moveRight];
        return;
    }
    
    switch (direction) {
        case upDirection:
            [sprite runAction:moveUp];
            ;
            break;
            
        case downDirection:
            [sprite runAction:moveDown];
            ;
            break;
            
        case leftDirection:
            [sprite runAction:moveLeft];
            ;
            break;
            
        case rightDirection:
            [sprite runAction:moveRight];
            ;
            break;
        default:
            break;
    }
    
    
    
}

@end
