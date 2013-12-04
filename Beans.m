//
//  Beans.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "Beans.h"


@implementation Beans

- (id)init
{
    if (self = [super init]) {
//        position = ccp(400, 200);
        sprite = [[CCSprite alloc] initWithFile:@"Blue.png"];
        [self setPointPosition:CGPointMake(3, 3)];

    }
    return self;
}

@end
