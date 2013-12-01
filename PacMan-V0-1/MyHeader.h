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

//游戏界面的左上角坐标
#define PLAYVIEW_X 50
#define PLAYVIEW_Y 50

//游戏界面的最小单位格的大小
#define POINT_LENGTH 25   


enum gameState {
    gameStart = 1,
    gamePause = 2
    };

enum direction {
    upDirection = 1,
    downDirection,
    leftDirection,
    rightDirection,
    noDirection
};

#endif
