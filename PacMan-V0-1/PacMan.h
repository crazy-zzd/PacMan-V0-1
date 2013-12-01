//
//  PacMan.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-8.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define X_INIT 100
#define Y_INIT 100


@interface PacMan : CCNode {
    CGPoint position;
}

+(PacMan *)shardPacMan;


@property CGPoint positon;
@end
