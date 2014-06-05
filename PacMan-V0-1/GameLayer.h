//
//  GameLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-15.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TouchLayerDelegate.h"
#import "MyHeader.h"



@class PauseLayer;
@class TouchLayer;
@class ControlNode;
@class PlayerMan;
@class MonsterMan;
@class Beans;

@class GameData;

@interface GameLayer : CCLayer<TouchLayerDelegate> {
    TouchLayer * theTouchLayer;
    ControlNode * theControNode;
    
    GameData * mainGameData;
    
    enum GameStyle mainGameStyle;
}

@property (nonatomic, strong)TouchLayer * theTouchLayer;
@property (nonatomic, strong)ControlNode * theControNode;

@property (nonatomic, assign)enum GameStyle mainGameStyle;

+(CCScene *)SceneWithStyle:(enum GameStyle)theStyle;



@end
