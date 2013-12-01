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


@class TouchLayer;
@class ControlNode;
@class PlayerMan;
@class MonsterMan;
@class Beans;

@interface GameLayer : CCLayer<TouchLayerDelegate> {
    TouchLayer * theTouchLayer;
    ControlNode * theControNode;
}

@property TouchLayer * theTouchLayer;
@property ControlNode * theControNode;

+(CCScene *)Scene;

-(void)viewDidLoad;


@end
