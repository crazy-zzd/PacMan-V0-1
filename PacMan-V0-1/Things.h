//
//  Things.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"


@interface Things : CCNode {
    CGPoint pointPosition;
    CCSprite * sprite;
}

//设置坐标，获取坐标
-(void)setPosition:(CGPoint) thePosition;
-(CGPoint)mapPosition;

//设置地图点坐标，获取地图点坐标
-(void)setPointPosition:(CGPoint) thePointPosition;
-(CGPoint)pointPosition;

//获得精灵
-(CCSprite *)sprite;

//获得精灵的大小
-(CGRect)spriteRect;

@end
