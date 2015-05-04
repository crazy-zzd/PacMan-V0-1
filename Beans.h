//
//  Beans.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Things.h"
#import "MyHeader.h"

@interface Beans : Things {
    int beanScore;
    void(^eatenBlock)();
}

- (id)initWithPosition:(CGPoint)thePosition withScore:(int)theScore;

- (int)beanScore;

- (void)beEaten;

- (void)setBeanEatenCallBack:(void(^)())theEatenBlock;
@end
