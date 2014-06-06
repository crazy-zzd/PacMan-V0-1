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
    
    _pausePosition = CGPointMake(520, 40);
    _pausePngFile = @"pause.png";
    _pausePngHLFile = @"pause_HL.png";
    
    _scorePosition = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 15);
}

- (void)ironInit
{
    _mapPngFile = @"IronGame_Background.png";
    _mapTextFile = @"IronMap";
    _mapWidthPoint = 56;
    _mapHeightPoint = 29;
    _mapPosition = CGPointMake(4, 0);
    
    _playerPosition = CGPointMake(27, 12);
    _playerDirection = rightDirection;
    
    _monstersPosition = [NSMutableArray array];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(25, 15)]];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(27, 15)]];
    [_monstersPosition addObject:[NSValue valueWithCGPoint:CGPointMake(29, 15)]];
    _monstersDirection = [NSMutableArray array];
    [_monstersDirection addObject:@(upDirection)];
    [_monstersDirection addObject:@(upDirection)];
    [_monstersDirection addObject:@(upDirection)];
    
    _beanPngFile = @"IronGame_Bean.png";
    
    _pausePosition = CGPointMake(548, SCREEN_HEIGHT - 15);
    _pausePngFile = @"IronGame_Pause.png";
    _pausePngHLFile = @"IronGame_Pause_HL.png";

    _scorePosition = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 15);
}

@end
