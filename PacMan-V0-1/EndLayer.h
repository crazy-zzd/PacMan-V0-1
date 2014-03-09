//
//  EndLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-3-9.
//  Copyright 2014年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PauseLayer.h"

@interface EndLayer : PauseLayer {
    NSString * score;
}

-(id)initWithScore:(NSString *)theScore;

@end
