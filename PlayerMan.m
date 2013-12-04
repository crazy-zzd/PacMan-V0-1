//
//  PlayerMan.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "PlayerMan.h"


@implementation PlayerMan

- (id)init
{
    if (self = [super init]) {
        direction = leftDirection;
        sprite = [[CCSprite alloc] initWithFile:@"Blue.png"];
        [self setPointPosition:CGPointMake(1, 1)];
    }
    return self;
}

@end
