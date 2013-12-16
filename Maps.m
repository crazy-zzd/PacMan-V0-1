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
        
        //初始化地图，通过地图文本文件
        [self handleMap];
    
    }
    return self;
}


//通过PointPosition找到是不是墙
- (BOOL)isWallWithPointPosition:(CGPoint)thePointPosition
{
    int x,y;
    x = (int)thePointPosition.x;
    y = (int)thePointPosition.y;
    return pointMap[x][y];
}

//通过一个左下角点坐标和长度找出这个点的中心坐标
- (CGPoint)getCentrePositionFromPointPosition:(CGPoint)thePointPosition withLengthPoint:(int)length
{
    CGPoint theCentrePosition;
    theCentrePosition.x = PLAYVIEW_X + thePointPosition.x * POINT_LENGTH + 0.5 * length * POINT_LENGTH;
    theCentrePosition.y = PLAYVIEW_Y + thePointPosition.y * POINT_LENGTH + 0.5 * length * POINT_LENGTH;
    return theCentrePosition;
}


//给出中心点的图坐标跟大小，还有移动的方向，算出是否碰撞到墙壁
- (BOOL)isCrashedWallWithCentrePosition:(CGPoint)thePosition withLengthPoint:(int)length withDirection:(int)theDirection
{

    CGRect theMainRect;
    theMainRect = CGRectMake(thePosition.x - length * POINT_LENGTH * 0.5, thePosition.y - length * POINT_LENGTH * 0.5, length * POINT_LENGTH, length * POINT_LENGTH);
    
    //先判断有没有走出边界
    if ([self isCrashedBoundaryWithRect:theMainRect]) {
        return YES;
    }
    
    //然后找出所有的边界的格子，看看是否是墙，然后会不会跟角色重合
    CGPoint beginPointPositon = [self getPointPositionFromCentrePosition:theMainRect.origin];
    
    for (int i = beginPointPositon.x; i <= beginPointPositon.x + length; i ++ ) {
        for (int j = beginPointPositon.y; j <= beginPointPositon.y + length; j ++) {
            if (pointMap[i][j] == 1) {
                CGRect theRect = [self getRectFromPointPosition:CGPointMake(i, j)];
                if (CGRectIntersectsRect(theMainRect, theRect)) {
                    return YES;
                }
            }
        }
    }
    
    return NO;
    

}

#pragma mark - 私有方法

- (void)handleMap
{

    NSError *error;
    NSString * textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"map" ofType:@"txt"] encoding:NSUTF8StringEncoding error:& error]; 
    
    if (textFileContents == nil) {
        
        // an error occurred
        
        NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
        
    }
    
    NSArray *lines = [textFileContents componentsSeparatedByString:@"\n"];
    
    NSLog(@"Number of lines in the file:%d", [lines count] );
    NSLog(@"%@",[lines objectAtIndex:0]);
    NSString * theLine;
    char theChar;
    for (int i = 0; i < MAP_HEIGTH_POINT; i ++) {
        theLine = [lines objectAtIndex:MAP_HEIGTH_POINT - 1 - i];
        for (int j = 0; j < MAP_WIDTH_POINT; j++) {
            theChar = [theLine characterAtIndex:j];
            if (theChar == '0') {
                pointMap[j][i] = 0;
            }
            else{
                pointMap[j][i] = 1;
            }
        }
    }
    
}

//判断矩形是不是到达地图边界了
- (BOOL)isCrashedBoundaryWithRect:(CGRect)theRect
{
    BOOL leftBoundary = theRect.origin.x < PLAYVIEW_X;
    BOOL downBoundary = theRect.origin.y < PLAYVIEW_Y;
    BOOL rightBoundary = theRect.origin.x + theRect.size.width > PLAYVIEW_X + MAP_WIDTH_POINT * POINT_LENGTH;
    BOOL upBoundary = theRect.origin.y + theRect.size.height > PLAYVIEW_Y + MAP_HEIGTH_POINT * POINT_LENGTH;
    return leftBoundary || downBoundary || rightBoundary || upBoundary;
}

//通过一个点坐标得到矩形
- (CGRect)getRectFromPointPosition:(CGPoint) thePointPosition
{
    CGPoint theCentrePosition = [self getCentrePositionFromPointPosition:thePointPosition withLengthPoint:1];
    CGRect theResultRect = CGRectMake(theCentrePosition.x - 0.5 * POINT_LENGTH, theCentrePosition.y - 0.5 * POINT_LENGTH, POINT_LENGTH, POINT_LENGTH);
    return theResultRect;
}

//通过一个中心点图坐标找到相应的点坐标
- (CGPoint)getPointPositionFromCentrePosition:(CGPoint)theCentrePosition
{
    CGPoint thePointPosition;
    thePointPosition.x = (int)((theCentrePosition.x - PLAYVIEW_X) / POINT_LENGTH);
    thePointPosition.y = (int)((theCentrePosition.y - PLAYVIEW_Y) / POINT_LENGTH);
    return thePointPosition;
}

@end
