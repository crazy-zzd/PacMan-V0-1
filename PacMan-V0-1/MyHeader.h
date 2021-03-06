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
#define TAG_PAUSELAYER 103
#define TAG_ENDLAYER 104

#define TAG_PAUSEBTN 111

#define TAG_TIMEBTN 112

//游戏界面的左下角坐标
#define PLAYVIEW_X 5
#define PLAYVIEW_Y 60


//游戏界面的最小单位格的大小
#define POINT_LENGTH 10

//地图的长宽格子数
#define MAP_WIDTH_POINT 56
#define MAP_HEIGTH_POINT 22

//屏幕大小
#define SCREEN_WIDTH 568
#define SCREEN_HEIGHT 320

//图标的图片文件名
#pragma mark - 图标
#define PNG_BACKGROUND @"background.png"
#define PNG_PACMAN @"pac-man-1.png"
#define PNG_MONSTER @"monster.png"
#define PNG_BEAN @"bean.png"
#define PNG_PAUSE @"pause.png"

//Man.m 移动
#define MOVEMENT 1
#define UP_MOVEMENT CGPointMake(0 ,MOVEMENT)
#define DOWN_MOVEMENT CGPointMake(0 ,-MOVEMENT)
#define LEFT_MOVEMENT CGPointMake(-MOVEMENT ,0)
#define RIGHT_MOVEMENT CGPointMake(+MOVEMENT ,0)

//Man.m 动作序列
#define TAG_SEQUENCE 21

//MonsterMan.m 动画
#define TAG_ANIMATION_REPEAT 55

//移动速度
#define MONSTERS_SPEED 70
#define PLAYER_SPEED 100

#define MOVING_SPEED 80

//Monster初始位置、方向
#define MONSTER_POINTPOSITION1 CGPointMake(25, 9)
#define MONSTER_DIRECTION1 leftDirection
#define MONSTER_POINTPOSITION2 CGPointMake(27, 9)
#define MONSTER_DIRECTION2 leftDirection
#define MONSTER_POINTPOSITION3 CGPointMake(29, 9)
#define MONSTER_DIRECTION3 leftDirection

#define MONSTER_CHANGEDIRECTION_LEASTTIME 0.3
#define MONSTER_CHANGEDIRECTION_MOSTTIME 1.8


//PacMan初始位置、方向
#define PLAYER_POINTPOSITION CGPointMake(0, 0)
#define PLAYER_DIRECTION rightDirection

//分数显示牌的位置
#define SCORE_INIT_STRING @"0"
#define SCORE_POSITION CGPointMake(424, 310)
#define SCORE_FONTNAME @"Arial"
#define SCORE_FONTSIZE 20

//beans分数
#define BEAN_SCORE 10


enum gameState {
    gameBefore = 1,
    gameStart,
    gamePause,
    gameOver
};

enum direction {
    upDirection = 1,
    rightDirection,
    downDirection,
    leftDirection
//    noDirection
};

enum manState {
    moving = 1,
    standing = 2
};

enum GameStyle {
    IronStyle = 100,
    SummerStyle = 101
};

#endif
