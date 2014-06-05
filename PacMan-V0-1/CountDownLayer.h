//
//  CountDownLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-5.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface CountDownLayer : CCLayer{
    CCSprite * number1;
    CCSprite * number2;
    CCSprite * number3;
    int count;
}

-(BOOL)countNumber;

@end
