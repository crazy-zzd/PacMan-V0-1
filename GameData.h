//
//  GameData.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-5.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "CCNode.h"

#import "MyHeader.h"
#import "SimpleAudioEngine.h"

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
@property (nonatomic, copy) NSString * timeBeanPngFile;
@property (nonatomic, copy) NSString * fruitBean;
@property (nonatomic, copy) NSString * doubleBeanPngFile;

//暂停按钮
@property (nonatomic, assign) CGPoint pausePosition;
@property (nonatomic, copy) NSString * pausePngFile;
@property (nonatomic, copy) NSString * pausePngHLFile;

//分数
@property (nonatomic, assign) CGPoint scorePosition;
@property (nonatomic, copy) NSString * scoreName;
@property (nonatomic, assign) ccColor3B scoreColor;

//时间条
@property (nonatomic, copy) NSString * timeLineFile;

//增加时间按钮
@property (nonatomic, assign) CGPoint addTimePosition;
@property (nonatomic, copy) NSString * addTimeFile;
@property (nonatomic, copy) NSString * addTimeHLFile;
@property (nonatomic, copy) NSString * addTimeDisFile;

//音乐音效设置
@property (nonatomic, assign) BOOL isMusic;
@property (nonatomic, assign) BOOL isSound;

@property (nonatomic, assign) ALuint soundId;

+(GameData *)sharedData;

-(enum GameStyle)nowStyle;

-(void)setStyle:(enum GameStyle)theStyle;

@end
