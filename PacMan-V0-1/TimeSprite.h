//
//  TimeSprite.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-6.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "CCSprite.h"

@interface TimeSprite : CCSprite{
    GLfloat percent;
    
    CCSprite * right;
    CCSprite * middle;
}

- (void)setTimePercent:(GLfloat)thePercent;

@end
