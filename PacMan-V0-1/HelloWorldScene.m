//
//  HelloWorldScene.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-8.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "HelloWorldScene.h"
#import "TouchLayer.h"
#import "DisplayLayer.h"
#import "ControlNode.h"
#import "Man.h"
#import "PlayerMan.h"
#import "MonsterMan.h"
#import "AppDelegate.h"

//static HelloWorldScene *sharedScene = nil; //第一步：静态实例，并初始化。




@implementation HelloWorldScene

@synthesize player;
@synthesize monsters;
@synthesize beans;

#pragma mark - 正常模式

+ (HelloWorldScene *)Scene
{
    HelloWorldScene * scene = [HelloWorldScene node];
    

    
    return scene;
}

#pragma mark - 单例模式



//+ (HelloWorldScene *) sharedScene  //第二步：实例构造检查静态实例是否为nil
//{
//    //网络上唯一可行的实现方法，但是会发生卡顿
//    @synchronized (self)
//    {
//        if (sharedScene == nil)
//        {
//            sharedScene = [[self alloc] init];
//        }
//    }
//    
//    //书上的实现方法，无法启动应用
////    static dispatch_once_t once = 0;
////    dispatch_once(&once, ^{
////        sharedScene = [[self alloc] init];
////    });
//    
//    //网络上找的实现方法，无法启动应用
////    NSAssert(sharedScene != nil, @"MultiLayerScene not available!");
//
//    return sharedScene;
//}
////
//+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
//{
//    @synchronized (self) {
//        if (sharedScene == nil) {
//            sharedScene = [super allocWithZone:zone];
//            return sharedScene;
//        }
//    }
//    return nil;
//}

//- (id) copyWithZone:(NSZone *)zone //第四步
//{
//    return self;
//}

#pragma mark - 初始化

- (id)init
{
    @synchronized(self) {
//        sharedScene = [super init];//往往放一些要初始化的变量.
    
    if (self = [super init]) {
        //初始化控制对象
        theControlNode = [ControlNode node];
        player = [theControlNode player];
        monsters = [theControlNode monsters];
        beans = [theControlNode beans];


        //初始化两个层对象
        theTouchLayer = [TouchLayer node];
        theDisplayLayer = [DisplayLayer node];

        [sharedScene addChild:theDisplayLayer z:Z_DISPLAYLAYER tag:TAG_DISPLAYLAYER];
        [sharedScene addChild:theTouchLayer z:Z_TOUCHLAYER tag:TAG_TOUCHLAYER];
        [sharedScene addChild:theControlNode];

        
        directionSymbol = noDirection;
    }

    
        return self;
    }
}


#pragma mark - 接受发送触摸消息 

- (void)setDirectorSymbol:(int)theDirection
{
//    directionSymbol = theDirection;
    [player moveWithDirection:theDirection];
}

- (int)getDirecitonSymbol
{
    return directionSymbol;
}



@end
