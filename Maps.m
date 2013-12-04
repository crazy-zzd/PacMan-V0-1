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

- (id)init
{
    self = [super init];
    if (self) {
        width = 8;
        heigth = 8;
        
        for (int i = 0; i < heigth; i++) {
            for (int j = 0; j < width; j++) {
                pointMap[i][j] = 0;
            }
        }
        
        for (int i = 0; i < heigth; i++) {
            pointMap[i][0] = 1;
            pointMap[i][width] = 1;
        }
        
        for (int j = 0; j < width; j++) {
            pointMap[0][j] = 1;
            pointMap[heigth][j] = 1;
        }
        
        pointMap[3][3] = 1;

//        pointMap[3][1] = 1;
    }
    return self;
}

- (void)setMap:(NSString *)fileName
{
    theMap = [[CCSprite alloc] initWithFile:fileName];
    [self handleMap];
}

//通过图坐标来查看是不是墙，无法实现，由于分界线无法识别是不是墙，分界线两边都有可能
//- (BOOL)isWallWithPosition:(CGPoint)thePosition
//{
//    int x = 0, y = 0;
//    x = (thePosition.x - PLAYVIEW_X) / POINT_LENGTH;
//    y = (thePosition.y - PLAYVIEW_Y) / POINT_LENGTH;
//    
//    return pointMap[x][y];
//}

- (BOOL)isWallWithPointPosition:(CGPoint)thePointPosition
{
    int x,y;
    x = (int)thePointPosition.x;
    y = (int)thePointPosition.y;
    return pointMap[x][y];
}

#pragma mark - 私有方法

- (void)handleMap
{
    //some code for handling map..
}

@end
