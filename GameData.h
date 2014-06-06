//
//  GameData.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-5.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "CCNode.h"

#import "MyHeader.h"

@interface GameData : CCNode{
    enum GameStyle mainStyle;
}

//地图
@property (nonatomic, copy) NSString * mapPngFile;
@property (nonatomic, assign) CGPoint mapPosition;
@property (nonatomic, copy) NSString * mapTextFile;
@property (nonatomic, assign) int mapWidthPoint;
@property (nonatomic, assign) int mapHeightPoint;

//人物
@property (nonatomic, assign) CGPoint playerPosition;
@property (nonatomic, assign) enum direction playerDirection;
@property (nonatomic, strong) NSMutableArray * monstersPosition;
@property (nonatomic, strong) NSMutableArray * monstersDirection;

//豆子
@property (nonatomic, copy) NSString * beanPngFile;

//暂停按钮
@property (nonatomic, assign) CGPoint pausePosition;
@property (nonatomic, copy) NSString * pausePngFile;
@property (nonatomic, copy) NSString * pausePngHLFile;

//分数
@property (nonatomic, assign) CGPoint scorePosition;
@property (nonatomic, copy) NSString * scoreName;

//时间条
@property (nonatomic, copy) NSString * timeLineFile;

//音乐音效设置
@property (nonatomic, assign) BOOL isMusic;
@property (nonatomic, assign) BOOL isSound;

+(GameData *)sharedData;

-(enum GameStyle)nowStyle;

-(void)setStyle:(enum GameStyle)theStyle;

@end
