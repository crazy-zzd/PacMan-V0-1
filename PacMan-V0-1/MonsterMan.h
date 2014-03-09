//
//  MonsterMan.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Man.h"
#import "MyHeader.h"

@class Maps;

@interface MonsterMan : Man {
    int indexOfMonster;
    
    NSMutableArray * animationArray;
}

-(id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection withIndex:(int)index;

@end
