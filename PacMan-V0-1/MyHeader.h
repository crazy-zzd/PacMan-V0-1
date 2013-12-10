//
//  MyHeader.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright (c) 2013年 朱 俊健. All rights reserved.
//

#ifndef PacMan_V0_1_MyHeader_h
#define PacMan_V0_1_MyHeader_h

#define TAG_TOUCHLAYER 100
#define TAG_CONTROLNODE 101
#define TAG_GAMELAYER 102

//游戏界面的左下角坐标
#define PLAYVIEW_X 0
#define PLAYVIEW_Y 80


//游戏界面的最小单位格的大小
#define POINT_LENGTH 10

//地图的长宽格子数
#define MAP_WIDTH_POINT 57
#define MAP_HEIGTH_POINT 22

//屏幕大小
#define SCREEN_WIDTH 568
#define SCREEN_HEIGHT 320

enum gameState {
    gameStart = 1,
    gamePause = 2
    };

enum direction {
    upDirection = 0,
    rightDirection,
    downDirection,
    leftDirection,
    noDirection
};

enum manState {
    moving = 1,
    standing = 2
    };

//图标的图片文件名
#pragma mark - 图标
#define PNG_BACKGROUND @"background1@2x.png"
#define PNG_PACMAN @"pacman@2x.png"
#define PNG_MONSTER @"monster@2x.png"
#define PNG_BEAN @"bean@2x.png"
#define PNG_PAUSE @"pause@2x.png"

//Man.m 移动
#define MOVEMENT 1
#define UP_MOVEMENT CGPointMake(0 ,MOVEMENT)
#define DOWN_MOVEMENT CGPointMake(0 ,-MOVEMENT)
#define LEFT_MOVEMENT CGPointMake(-MOVEMENT ,0)
#define RIGHT_MOVEMENT CGPointMake(+MOVEMENT ,0)


//Monster初始位置、方向
#define MONSTER_POINTPOSITION1 CGPointMake(26, 9)
#define MONSTER_DIRECTION1 upDirection
#define MONSTER_POINTPOSITION2 CGPointMake(29, 9)
#define MONSTER_DIRECTION2 upDirection
#define MONSTER_CHANGEDIRECTION_TIME_LEATEST 0.3
#define MONSTER_CHANGEDIRECTION_TIME_MOST 1.8

//PacMan初始位置、方向
#define PLAYER_POINTPOSITION CGPointMake(0, 0)
#define PLAYER_DIRECTION rightDirection

//分数显示牌的位置
#define SCORE_INIT_STRING @"0"
#define SCORE_POSITION CGPointMake(470, 310)
#define SCORE_FONTNAME nil
#define SCORE_FONTSIZE 20

//beans分数
#define BEAN_SCORE 10

#endif
