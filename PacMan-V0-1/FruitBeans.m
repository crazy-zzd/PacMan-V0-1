//
//  FruitBeans.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 15-5-4.
//  Copyright (c) 2015年 朱 俊健. All rights reserved.
//

#import "FruitBeans.h"
#import "GameData.h"

@implementation FruitBeans
- (id)initWithPosition:(CGPoint)thePosition withScore:(int)theScore
{
    if (self = [super initWithPosition:thePosition withScore:theScore]) {
        sprite = [[CCSprite alloc] initWithFile:[GameData sharedData].fruitBean];
        [self setPosition:thePosition];

        beanScore = theScore * 5;
    }
    return self;
}
@end
