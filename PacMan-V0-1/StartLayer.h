//
//  StartLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-12-26.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"
#import "GameLayer.h"

@class AboutUsLayer;

@interface StartLayer : CCLayer {
    
//Iron Style
    
    
//Summer Style
    NSMutableArray * clounds;
    
    CCSprite * sunny;
    
    NSMutableArray * monsters;
    
    int theJumpMonster;
    
    AboutUsLayer * infoLayer;
}

+ (CCScene *)Scene;

@end
