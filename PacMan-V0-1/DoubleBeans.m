//
//  DoubleBeans.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 15-5-4.
//  Copyright (c) 2015年 朱 俊健. All rights reserved.
//

#import "DoubleBeans.h"
#import "GameData.h"

@implementation DoubleBeans
- (id)initWithPosition:(CGPoint)thePosition withScore:(int)theScore
{
    if (self = [super initWithPosition:thePosition withScore:theScore]) {
        sprite = [[CCSprite alloc] initWithFile:[GameData sharedData].doubleBeanPngFile];
        [self setPosition:thePosition];

        beanScore = theScore;
    }
    return self;
}
@end
