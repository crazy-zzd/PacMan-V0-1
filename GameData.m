//
//  GameData.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-5.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "GameData.h"

@implementation GameData


static GameData * sharedData = nil;

+ (GameData *)sharedData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    return sharedData;
}

- (enum GameStyle)nowStyle
{
    return mainStyle;
}

- (void)setStyle:(enum GameStyle)theStyle
{
    [self initWithStyle:theStyle];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initWithStyle:IronStyle];
        _isMusic = YES;
        _isSound = YES;
        
        _soundId = 0;
    }
    return self;
}

- (void)initWithStyle:(enum GameStyle)theStyle
{
    mainStyle = theStyle;
    
    
    if (mainStyle == IronStyle) {
        [self ironInit];
    }
    else{
        [self summerInit];
    }
}

- (void)summerInit
{
    _mapPngFile = @"background.png";
    _mapTextFile = @"map";
    _mapWidthPoint = 56;
    _mapHeightPoint = 22;
    _mapPosition = CGPointMake(5, 60);
    
    _playerPosition = CGPointMake(0, 0);
    _playerDirection = rightDirection;
    
    _monstersPosition = [NSMutableArray array];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(25, 9)]];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(27, 9)]];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(29, 9)]];
    _monstersDirection = [NSMutableArray array];
    [_monstersDirection addObject:@(leftDirection)];
    [_monstersDirection addObject:@(leftDirection)];
    [_monstersDirection addObject:@(leftDirection)];
    
    _beanPngFile = @"bean.png";
    _timeBeanPngFile = @"timebean.png";
    
    _pausePosition = CGPointMake(1090 / 2, SCREEN_HEIGHT - 32 / 2);
    _pausePngFile = @"Summer_Pause.png";
    _pausePngHLFile = @"pause_HL.png";
//    _pausePngFile = @"IronGame_Pause.png";
//    _pausePngHLFile = @"IronGame_Pause_HL.png";
    
    _scorePosition = CGPointMake(577.5 / 2, SCREEN_HEIGHT - 35.5 / 2);
    _scoreName = @"9PX2BUS";
    _scoreColor = ccc3(0, 158, 219);
    
    _timeLineFile = @"Game_TimeLine_Background_Summer.png";
    
    _addTimePosition = CGPointMake(1090 / 2, 32 / 2);
    _addTimeFile = @"Summer_Pause.png";
    _addTimeHLFile = @"pause_HL.png";
    _addTimeDisFile = @"pause_HL.png";
    
}

- (void)ironInit
{
    _mapPngFile = @"IronGame_Background.png";
    _mapTextFile = @"IronMap";
    _mapWidthPoint = 56;
    _mapHeightPoint = 24;
    _mapPosition = CGPointMake(4, 50);
    
    _playerPosition = CGPointMake(27, 7);
    _playerDirection = rightDirection;
    
    _monstersPosition = [NSMutableArray array];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(25, 10)]];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(27, 10)]];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(29, 10)]];
    _monstersDirection = [NSMutableArray array];
    [_monstersDirection addObject:@(upDirection)];
    [_monstersDirection addObject:@(upDirection)];
    [_monstersDirection addObject:@(upDirection)];
    
    _beanPngFile = @"IronGame_Bean.png";
    _timeBeanPngFile = @"IronGame_TimeBean.png";
    
    _pausePosition = CGPointMake(548, SCREEN_HEIGHT - 15);

//    _pausePngFile = @"pause.png";
//    _pausePngHLFile = @"pause_HL.png";

    _pausePngFile = @"IronGame_Pause.png";
    _pausePngHLFile = @"IronGame_Pause_HL.png";

    _scorePosition = CGPointMake(577.5 / 2, SCREEN_HEIGHT - 35.5 / 2);
    _scoreName = @"9PX2BUS";
    _scoreColor = ccc3(188, 188, 188);
    
    _timeLineFile = @"Game_TimeLine_Background.png";
    
    _addTimePosition = CGPointMake(1090 / 2, 32 / 2);
    _addTimeFile = @"Summer_Pause.png";
    _addTimeHLFile = @"pause_HL.png";
    _addTimeDisFile = @"pause_HL.png";
}

@end
