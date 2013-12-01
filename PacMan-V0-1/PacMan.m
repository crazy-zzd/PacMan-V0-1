//
//  PacMan.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-8.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "PacMan.h"

static PacMan *sharedPanMan = nil; //第一步：静态实例，并初始化。

@implementation PacMan

@synthesize position;

+ (PacMan *) shardPacMan  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedPanMan == nil)
        {
            sharedPanMan = [[self alloc] init];
        }
    }
    return sharedPanMan;
}

+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self) {
        if (sharedPanMan == nil) {
            sharedPanMan = [super allocWithZone:zone];
            return sharedPanMan;
        }
    }
    return nil;
}

- (id) copyWithZone:(NSZone *)zone //第四步
{
    return self;
}



- (id)init
{
    @synchronized(self) {
        sharedPanMan = [super init];//往往放一些要初始化的变量.
        position = ccp(X_INIT, Y_INIT);
        return self;
    }
}

@end
