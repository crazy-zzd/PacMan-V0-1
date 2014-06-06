//
//  TimeSprite.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-6.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "TimeSprite.h"

#import "GameData.h"

@implementation TimeSprite

- (id)init
{
    self = [super init];
    if (self) {
        
        percent = 1.0;
        
        CCSprite * background = [[CCSprite alloc] initWithFile:[GameData sharedData].timeLineFile];
        [self addChild:background];
        
        left = [[CCSprite alloc] initWithFile:@"Game_TimeLine_Left.png"];
        left.position = CGPointMake(- 80.25, 0);
        [self addChild:left];
        
        right = [[CCSprite alloc] initWithFile:@"Game_TimeLine_Right.png"];
        right.position = CGPointMake(80.25, 0);
        [self addChild:right];
        
        middle = [[CCSprite alloc] initWithFile:@"Game_TimeLine_Middle.png" rect:CGRectMake(0, 0, 79 * 2, 4.5)];
        [self addChild:middle];
        
//        [self setTimePercent:1];
    }
    return self;
}

- (void)setTimePercent:(GLfloat)thePercent
{
    percent = thePercent;
    right.position = CGPointMake(- 79 + 2.25 + thePercent * (79 - 2.25 + 80.25) - 0.5, 0);
    
    
    middle.textureRect = CGRectMake(0, 0, thePercent * 158, 4.5);
    middle.position = CGPointMake((- 79 + thePercent * 79), 0);

//    if (percent < 0.25) {
    ccColor3B red = ccc3(56 * (1 - thePercent) + 197, 194 * thePercent, 214 * thePercent);
    [left setColor:red];
    [middle setColor:red];
    [right setColor:red];
//    }
}

@end
