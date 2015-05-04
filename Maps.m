//
//  Maps.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-15.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Maps.h"

#import "GameData.h"

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
        
        //初始化数据文件
        mainGameData = [GameData sharedData];
        
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

//通过一个左下角点坐标和长度，找出这个点的中心坐标
- (CGPoint)getCentrePositionFromPointPosition:(CGPoint)thePointPosition withLengthPoint:(int)length
{
    CGPoint theCentrePosition;
    theCentrePosition.x = mainGameData.mapPosition.x + thePointPosition.x * POINT_LENGTH + 0.5 * length * POINT_LENGTH;
    theCentrePosition.y = mainGameData.mapPosition.y + thePointPosition.y * POINT_LENGTH + 0.5 * length * POINT_LENGTH;
    return theCentrePosition;
}

#pragma mark - 对外接口

//给出中心图坐标，长度，第一方向，第二方向，返回一个数据包，分别是两个CGPoint，两个目的地
- (NSArray * )moveWithCentrePosition:(CGPoint)theCentrePosition withLengthPoint:(int)length withFirstDirection:(int)theFirstDirection withSecondDirection:(int)theSecondDirection
{
    int numOfDestination = 0;
    CGPoint first = CGPointMake(0, 0);
    CGPoint second = CGPointMake(0, 0);
    
    //首先处理方向问题
    //方向相同时
    if (theFirstDirection == theSecondDirection) {
        numOfDestination = 1;
    }
    //方向相反时
    if ((theFirstDirection - theSecondDirection == 2)||(theFirstDirection - theSecondDirection == -2)) {
        numOfDestination = 1;
        theFirstDirection = theSecondDirection;
    }
    //其它情况
    if (theFirstDirection != theSecondDirection) {
        numOfDestination = 2;
    }
    
    //然后获得目的地坐标，当方向个数不同时分情况讨论
    if (numOfDestination == 1) {
        second = first = [self getDestinationCentrePositionWith:theCentrePosition with:theFirstDirection with:length];
    }
    else{
        NSArray * positions = [self getDestinationCentrePositionsWith:theCentrePosition with:theFirstDirection with:theSecondDirection with:length];
        NSValue * position = (NSValue * )[positions objectAtIndex:0];
        first = [position CGPointValue];
        position = (NSValue * )[positions objectAtIndex:1];
        second = [position CGPointValue];
    }
    
    
    if (CGPointEqualToPoint(theCentrePosition, first)) {
        if (CGPointEqualToPoint(first, second)) {
            return [NSArray arrayWithObjects:[NSNumber numberWithInt:0], nil];
        }
        else{
            return [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSValue valueWithCGPoint:second], nil];
        }
    }
    else{
        if (CGPointEqualToPoint(first, second)) {
            return [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSValue valueWithCGPoint:first], nil];
        }
        else{
            return [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSValue valueWithCGPoint:first], [NSValue valueWithCGPoint:second], nil];
        }
    }
}

#pragma mark - 私有方法

#pragma mark - make maps
- (void)handleMap
{
    NSError *error;
    NSString * textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:mainGameData.mapTextFile ofType:@"txt"] encoding:NSUTF8StringEncoding error:& error];
    
    if (textFileContents == nil) {
        
        NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
        
    }
    
    NSArray *lines = [textFileContents componentsSeparatedByString:@"\n"];

    NSString * theLine;
    char theChar;
    for (int i = 0; i < mainGameData.mapHeightPoint; i ++) {
        theLine = [lines objectAtIndex:mainGameData.mapHeightPoint - 1 - i];
        for (int j = 0; j < mainGameData.mapWidthPoint; j++) {
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

#pragma mark - Position <-> PointPosition

//通过一个中心点图坐标找到相应的点坐标
- (CGPoint)getPointPositionFromCentrePosition:(CGPoint)theCentrePosition
{
    CGPoint thePointPosition;
    thePointPosition.x = (int)((theCentrePosition.x - mainGameData.mapPosition.x) / POINT_LENGTH);
    thePointPosition.y = (int)((theCentrePosition.y - mainGameData.mapPosition.y) / POINT_LENGTH);
    return thePointPosition;
}

//通过中心图坐标和长度，找出左下角点坐标
- (CGPoint)getLeftDownPointPositionFromCentrePosition:(CGPoint)theCentrePosition withLengthPoint:(int)length
{
    CGPoint thePointPosition;
    thePointPosition = [self getPointPositionFromCentrePosition:theCentrePosition];
    thePointPosition.x = (int)(thePointPosition.x - length / 2);
    thePointPosition.y = (int)(thePointPosition.y - length / 2);

    return thePointPosition;
}

//通过中心图坐标，左下角点坐标，长度，找出右上角点坐标
- (CGPoint)getRightUpPointPositionFromCentrePosition:(CGPoint)theCentrePosition withLeftDownPointPosition:(CGPoint)theLeftDownPointPosition withLengthPoint:(int)length
{
    CGPoint theRightUpPointPosition;
    if ([self isOnLineWithNumber:theCentrePosition.x withLine:mainGameData.mapPosition.x]) {
        theRightUpPointPosition.x = theLeftDownPointPosition.x + length - 1;
    }
    else{
        theRightUpPointPosition.x = theLeftDownPointPosition.x + length;
    }
    if ([self isOnLineWithNumber:theCentrePosition.y withLine:mainGameData.mapPosition.y]) {
        theRightUpPointPosition.y = theLeftDownPointPosition.y + length - 1;
    }
    else{
        theRightUpPointPosition.y = theLeftDownPointPosition.y + length;
    }
    return theRightUpPointPosition;
}


#pragma mark - move

//one step
//当只有一个方向时，通过中心点图坐标、方向、长度，获得移动的最终图坐标
- (CGPoint)getDestinationCentrePositionWith:(CGPoint)theCentrePosition with:(int)theDirection with:(int)length
{
    CGPoint nextStep = [self move1StepWith:theCentrePosition with:theDirection with:length];
    if (![self isBlockedWith:nextStep with:length]) {
        theCentrePosition = nextStep;
        return [self getDestinationCentrePositionWith:theCentrePosition with:theDirection with:length];
    }
    else{
        return theCentrePosition;
    }
    
}

//two steps
//当有两个方向时，通过中心点图坐标、第一方向、第二方向、长度，获得两个移动最终图坐标
- (NSArray *)getDestinationCentrePositionsWith:(CGPoint)theCentrePosition with:(int)theFirstDireciton with:(int)theSecondDirection with:(int)length
{
    CGPoint nextStep = [self move1StepWith:theCentrePosition with:theSecondDirection with:length];
    if (![self isBlockedWith:nextStep with:length]) {
        CGPoint theFirstPosition = theCentrePosition;
        CGPoint theSecondPosition = [self getDestinationCentrePositionWith:theCentrePosition with:theSecondDirection with:length];
        return [NSArray arrayWithObjects:[NSValue valueWithCGPoint:theFirstPosition], [NSValue valueWithCGPoint:theSecondPosition], nil];
    }
    else{
        nextStep = [self move1StepWith:theCentrePosition with:theFirstDireciton with:length];
        if (![self isBlockedWith:nextStep with:length]) {
            return [self getDestinationCentrePositionsWith:nextStep with:theFirstDireciton with:theSecondDirection with:length];
        }
        else{
            return [NSArray arrayWithObjects:[NSValue valueWithCGPoint:theCentrePosition], [NSValue valueWithCGPoint:theCentrePosition], nil];
        }
    }
}

//通过中心图坐标、方向、长度，算出下一步走到的中心图坐标
- (CGPoint)move1StepWith:(CGPoint)theCentrePosition with:(int)theDirection with:(int)length
{
    //首先判断是不是不在线上
    if (![self isOnLineWithNumber:theCentrePosition.x withLine:mainGameData.mapPosition.x]) {
        if (theDirection == rightDirection) {
            theCentrePosition.x = ((int)((theCentrePosition.x - mainGameData.mapPosition.x)/POINT_LENGTH)) * POINT_LENGTH + POINT_LENGTH + mainGameData.mapPosition.x;
            return theCentrePosition;
        }
        if (theDirection == leftDirection) {
            theCentrePosition.x = ((int)((theCentrePosition.x - mainGameData.mapPosition.x)/POINT_LENGTH)) * POINT_LENGTH + mainGameData.mapPosition.x;
            return theCentrePosition;
        }
    }
    if (![self isOnLineWithNumber:theCentrePosition.y withLine:mainGameData.mapPosition.y]) {
        if (theDirection == upDirection) {
            theCentrePosition.y = ((int)((theCentrePosition.y - mainGameData.mapPosition.y)/POINT_LENGTH)) * POINT_LENGTH + POINT_LENGTH + mainGameData.mapPosition.y;
            return theCentrePosition;
        }
        if (theDirection == downDirection) {
            theCentrePosition.y = ((int)((theCentrePosition.y - mainGameData.mapPosition.y)/POINT_LENGTH)) * POINT_LENGTH + mainGameData.mapPosition.y;
            return theCentrePosition;
        }
    }
    
    //算出Movement
    CGPoint movement;
    switch (theDirection) {
        case upDirection:
            movement = UP_MOVEMENT;
            break;
        case downDirection:
            movement = DOWN_MOVEMENT;
            break;
        case leftDirection:
            movement = LEFT_MOVEMENT;
            break;
        case rightDirection:
            movement = RIGHT_MOVEMENT;
            break;
        default:
            break;
    }
    movement =  ccpMult(movement, POINT_LENGTH);
    
    return ccpAdd(theCentrePosition, movement);
}

#pragma mark - check

//通过中心点图坐标、长度，检查吃豆人所在位置是否能通过
- (BOOL)isBlockedWith:(CGPoint)theCentrePosition with:(int)length
{
    //通过中心点坐标和长度，算出左下角的点坐标和右上角的点坐标
    CGPoint leftDownPointPosition = [self getLeftDownPointPositionFromCentrePosition:theCentrePosition withLengthPoint:length];
    CGPoint rightUpPointPosition = [self getRightUpPointPositionFromCentrePosition:theCentrePosition withLeftDownPointPosition:leftDownPointPosition withLengthPoint:length];
    
    //判断是不是到达地图边界
    if ((rightUpPointPosition.x >= mainGameData.mapWidthPoint) || (rightUpPointPosition.y >= mainGameData.mapHeightPoint) || (leftDownPointPosition.x < 0) || (leftDownPointPosition.y < 0)) {
        return YES;
    }
    
    //判断是不是有障碍物
    for (int x = leftDownPointPosition.x; x <= rightUpPointPosition.x; x ++) {
        for (int y = leftDownPointPosition.y; y <= rightUpPointPosition.y; y ++) {
            if (pointMap[x][y]) {
                return YES;
            }
        }
    }
    
    return NO;
}

//判断一个横座标（或者纵座标）是不是在线上
- (BOOL)isOnLineWithNumber:(int)theNumber withLine:(int)theLine
{
    int temp;
    theNumber = theNumber - theLine;
    temp = theNumber / POINT_LENGTH;
    theNumber = theNumber - temp * POINT_LENGTH;
    if (theNumber > 0) {
        return NO;
    }
    return YES;
}


@end
