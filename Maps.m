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
        [self handleMap];
//        width = 8;
//        heigth = 8;
//        
//        for (int i = 0; i < heigth; i++) {
//            for (int j = 0; j < width; j++) {
//                pointMap[i][j] = 0;
//            }
//        }
//        
//        for (int i = 0; i < heigth; i++) {
//            pointMap[i][0] = 1;
//            pointMap[i][width] = 1;
//        }
//        
//        for (int j = 0; j < width; j++) {
//            pointMap[0][j] = 1;
//            pointMap[heigth][j] = 1;
//        }
//        
//        pointMap[3][3] = 1;
    }
    return self;
}

- (void)setMap:(NSString *)fileName
{
    theMap = [[CCSprite alloc] initWithFile:fileName];
    [self handleMap];
}

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

//通过一个中心点图坐标找到相应的点坐标
- (CGPoint)getPointPositionFromCentrePosition:(CGPoint)theCentrePosition
{
    CGPoint thePointPosition;
    thePointPosition.x = (int)((theCentrePosition.x - PLAYVIEW_X) / POINT_LENGTH);
    thePointPosition.y = (int)((theCentrePosition.y - PLAYVIEW_Y) / POINT_LENGTH);
    return thePointPosition;
}

//给出中心点的坐标跟大小，还有移动的方向，算出是否碰撞到墙壁
- (BOOL)isCrashedWallWithCentrePosition:(CGPoint)thePosition withLengthPoint:(int)length withDirection:(int)theDirection
{
    //如果走到了范围外面，就返回撞墙
    switch (theDirection) {
        case upDirection:
            if (thePosition.y > PLAYVIEW_Y + MAP_HEIGTH_POINT * POINT_LENGTH - 0.5 * length * POINT_LENGTH) {
                return YES;
            }
            break;
        case downDirection:
            if (thePosition.y < PLAYVIEW_Y + 0.5 * length * POINT_LENGTH) {
                return YES;
            }
            ;
            break;
        case leftDirection:
            if (thePosition.x < PLAYVIEW_X + 0.5 * length * POINT_LENGTH) {
                return YES;
            }
            ;
            break;
        case rightDirection:
            if (thePosition.x > PLAYVIEW_X + MAP_WIDTH_POINT * POINT_LENGTH - 0.5 * length * POINT_LENGTH) {
                return YES;
            }
            ;
            break;
            
        default:
            break;
    }
    
    CGRect theMainRect;
    theMainRect = CGRectMake(thePosition.x - length * POINT_LENGTH * 0.5, thePosition.y - length * POINT_LENGTH * 0.5, length * POINT_LENGTH, length * POINT_LENGTH);
    CGPoint thePoint1,thePoint2,thePoint3;
    
    switch (theDirection) {
        case upDirection:
            thePoint1 = CGPointMake(thePosition.x - POINT_LENGTH, thePosition.y + 1.5 * POINT_LENGTH);
            thePoint2 = CGPointMake(thePosition.x, thePosition.y +1.5 *  POINT_LENGTH);
            thePoint3 = CGPointMake(thePosition.x + POINT_LENGTH, thePosition.y + 1.5 * POINT_LENGTH);
            ;
            break;
        case downDirection:
            thePoint1 = CGPointMake(thePosition.x - POINT_LENGTH, thePosition.y - 1.5 * POINT_LENGTH);
            thePoint2 = CGPointMake(thePosition.x, thePosition.y - 1.5 * POINT_LENGTH);
            thePoint3 = CGPointMake(thePosition.x + POINT_LENGTH, thePosition.y - 1.5 * POINT_LENGTH);
            ;
            break;
        case leftDirection:
            thePoint1 = CGPointMake(thePosition.x - 1.5 * POINT_LENGTH, thePosition.y - POINT_LENGTH);
            thePoint2 = CGPointMake(thePosition.x - 1.5 * POINT_LENGTH, thePosition.y);
            thePoint3 = CGPointMake(thePosition.x - 1.5 * POINT_LENGTH, thePosition.y + POINT_LENGTH);
            ;
            break;
        case rightDirection:
            thePoint1 = CGPointMake(thePosition.x + 1.5 * POINT_LENGTH, thePosition.y - POINT_LENGTH);
            thePoint2 = CGPointMake(thePosition.x + 1.5 * POINT_LENGTH, thePosition.y);
            thePoint3 = CGPointMake(thePosition.x + 1.5 * POINT_LENGTH, thePosition.y + POINT_LENGTH);
            ;
            break;
        default:
            break;
    }
    
    CGPoint thePointPosition;
    thePointPosition = [self getPointPositionFromCentrePosition:thePoint1];
    if (pointMap[(int)thePointPosition.x][(int)thePointPosition.y] == 1) {
        CGPoint theCentrePosition = [self getCentrePositionFromPointPosition:thePointPosition withLengthPoint:1];
        CGRect theRect = CGRectMake(theCentrePosition.x - 0.5 * POINT_LENGTH, theCentrePosition.y - 0.5 * POINT_LENGTH, POINT_LENGTH, POINT_LENGTH);
        if (CGRectIntersectsRect(theMainRect, theRect)) {
            return YES;
        }
    }
    thePointPosition = [self getPointPositionFromCentrePosition:thePoint2];
    if (pointMap[(int)thePointPosition.x][(int)thePointPosition.y] == 1) {
        CGPoint theCentrePosition = [self getCentrePositionFromPointPosition:thePointPosition withLengthPoint:1];
        CGRect theRect = CGRectMake(theCentrePosition.x - 0.5 * POINT_LENGTH, theCentrePosition.y - 0.5 * POINT_LENGTH, POINT_LENGTH, POINT_LENGTH);
        if (CGRectIntersectsRect(theMainRect, theRect)) {
            return YES;
        }
    }
    thePointPosition = [self getPointPositionFromCentrePosition:thePoint3];
    if (pointMap[(int)thePointPosition.x][(int)thePointPosition.y] == 1) {
        CGPoint theCentrePosition = [self getCentrePositionFromPointPosition:thePointPosition withLengthPoint:1];
        CGRect theRect = CGRectMake(theCentrePosition.x - 0.5 * POINT_LENGTH, theCentrePosition.y - 0.5 * POINT_LENGTH, POINT_LENGTH, POINT_LENGTH);
        if (CGRectIntersectsRect(theMainRect, theRect)) {
            return YES;
        }
    }
    
    
    return NO;
}

#pragma mark - 私有方法

- (void)handleMap
{
    //some code for handling map..
    
//    FILE *fp1;//定义文件流指针，用于打开读取的文件
//    FILE *fp2;//定义文件流指针，用于打开写操作的文件
//    int i = 0, j = 0;
//    char text[10000];//定义一个字符串数组，用于存储读取的字符
//    fp1 = fopen("map.txt","r");//只读方式打开文件a.txt
//    while(fgets(text,1024,fp1)!=NULL)//逐行读取fp1所指向文件中的内容到text中
//    {
//        for (i = 0; i < MAP_WIDTH_POINT; i ++) {
//            if (text[i] == '0') {
//                pointMap[i][j] = 0;
//            }
//            else{
//                pointMap[i][j] = 1;
//            }
//        }
//        j ++;
//    }
//    fclose(fp1);//关闭文件a.txt，有打开就要有关闭
//    fclose(fp2);//关闭文件b.txt
    NSError *error;
    NSString * textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"map" ofType:@"txt"] encoding:NSUTF8StringEncoding error:& error];
    // If there are no results, something went wrong
//    NSLog(@"%@",textFileContents);
    
    
    
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

@end
