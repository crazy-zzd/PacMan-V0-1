//
//  Maps.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-15.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Maps.h"

@implementation Maps

@synthesize mapsData;

static Maps * sharedMap = nil;

+ (Maps *)sharedMap
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMap = [[self alloc] init];
    });
    return sharedMap;
}

- (void)setMap:(NSString *)fileName
{
    theMap = [[CCSprite alloc] initWithFile:fileName];
    [self handleMap];
}

- (BOOL)isWall:(CGPoint)thePointPosition
{
    int x,y;
    x = (int)thePointPosition.x;
    y = (int)thePointPosition.y;
    return theMap[x][y];
}

#pragma mark - 私有方法

- (void)handleMap
{
    //some code for handling map..
}

@end
