//
//  DisplayLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "DisplayLayer.h"
#import "Man.h"
#import "HelloWorldScene.h"
#import "PlayerMan.h"
#import "MonsterMan.h"
#import "Beans.h"

@implementation DisplayLayer

-(id)init
{
    if (self = [super init]) {
    
        //添加玩家到屏幕上
        [self addChild:[HelloWorldScene sharedScene].player.sprite];
        NSMutableArray * monsters = [HelloWorldScene sharedScene].monsters;
        for (int i = 0; i < monsters.count; i++) {
            [self addChild:((MonsterMan *)[monsters objectAtIndex:i]).sprite];
        }
        NSMutableArray * beans = [HelloWorldScene sharedScene].beans;
        for (int i = 0; i < beans.count; i++) {
            [self addChild:((Beans *)[beans objectAtIndex:i]).sprite];
        }
        
        
    }
    return self;
}

@end
