//
//  Beans.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Beans.h"


@implementation Beans

- (id)initWithPosition:(CGPoint)thePosition withScore:(int)theScore
//-(id)init
{
    if (self = [super init]) {
        sprite = [[CCSprite alloc] initWithFile:PNG_BEAN];
//        [self setPointPosition:CGPointMake(4, 4)];
        [self setPointPosition:thePosition];

        beanScore = theScore;
    }
    return self;
}

- (int)beanScore
{
    return beanScore;
}

- (void)beEaten
{
    [sprite removeFromParent];
}

@end
