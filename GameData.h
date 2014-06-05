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

//@property (nonatomic, assign) enum GameStyle mainStyle;

@property (nonatomic, copy) NSString * mapPngFile;
@property (nonatomic, assign) CGPoint mapPosition;
@property (nonatomic, copy) NSString * mapTextFile;
@property (nonatomic, assign) int mapWidthPoint;
@property (nonatomic, assign) int mapHeightPoint;

@property (nonatomic, assign) CGPoint playerPosition;
@property (nonatomic, assign) enum direction playerDirection;
@property (nonatomic, strong) NSMutableArray * monstersPosition;
@property (nonatomic, strong) NSMutableArray * monstersDirection;

@property (nonatomic, assign) CGPoint pausePosition;
@property (nonatomic, copy) NSString * pausePngFile;
@property (nonatomic, copy) NSString * pausePngHLFile;

+(GameData *)sharedData;

-(enum GameStyle)nowStyle;

-(void)setStyle:(enum GameStyle)theStyle;

@end
