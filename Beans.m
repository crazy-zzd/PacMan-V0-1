//
//  Beans.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Beans.h"

#import "GameData.h"

@implementation Beans

- (id)initWithPosition:(CGPoint)thePosition withScore:(int)theScore
{
    if (self = [super init]) {
        sprite = [[CCSprite alloc] initWithFile:[GameData sharedData].beanPngFile];
        [self setPosition:thePosition];

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
    if (eatenBlock) {
        eatenBlock();
        NSLog(@"eatenBlock");
    }
    [sprite removeFromParent];
}
- (void)setBeanEatenCallBack:(void (^)())theEatenBlock
{
    eatenBlock = theEatenBlock;
}
@end
