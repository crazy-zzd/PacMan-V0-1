//
//  Maps.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-15.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"

@interface Maps : CCNode {
    CCSprite * theMap;
    BOOL pointMap [100][100];
    int width,heigth;
}

@property (nonatomic, strong) NSString * mapsData;


+(Maps *)sharedMap;

//-(void)setMap:(NSString *)fileName;

-(BOOL)isWallWithPointPosition:(CGPoint)thePointPosition;

-(CGPoint)getCentrePositionFromPointPosition:(CGPoint)thePointPosition withLengthPoint:(int)length;

-(BOOL)isCrashedWallWithCentrePosition:(CGPoint)thePosition withLengthPoint:(int)length withDirection:(int)theDirection;

@end
