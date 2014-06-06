//
//  SettingLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-7.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "SettingLayer.h"
#import "SimpleAudioEngine.h"

#import "MyHeader.h"
#import "GameData.h"

@implementation SettingLayer

- (id)init
{
    self = [super init];
    if (self) {
        
//        self.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        
        CCSprite * background = [[CCSprite alloc] initWithFile:@"Setting_Background.png"];
        background.position = CGPointMake(569 / 2, SCREEN_HEIGHT - 343.5 / 2);
        [self addChild:background];
        
        music = [[CCMenuItemImage alloc] initWithNormalImage:@"Setting_Music_On.png" selectedImage:@"Setting_Music_On_HL.png" disabledImage:nil target:self selector:@selector(onPressMusic:)];
        music.position = CGPointMake(379.5 / 2, SCREEN_HEIGHT - 343.5 / 2);

        sound = [[CCMenuItemImage alloc] initWithNormalImage:@"Setting_Sound_On.png" selectedImage:@"Setting_Sound_On_HL.png" disabledImage:nil target:self selector:@selector(onPressSound:)];
        sound.position = CGPointMake(758.0 / 2, SCREEN_HEIGHT - 343.5 / 2);
        
        CCMenuItemImage * transparent = [[CCMenuItemImage alloc] initWithNormalImage:@"AboutUs_Transparent.png" selectedImage:@"AboutUs_Transparent.png" disabledImage:nil target:self selector:@selector(onPressCloseBtn:)];
        transparent.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        
        CCMenu * menu = [CCMenu menuWithItems:music, sound, transparent, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        
        CCSprite * front = [[CCSprite alloc] initWithFile:@"Setting_Front.png"];
        front.position = CGPointMake(570 / 2, SCREEN_HEIGHT - 125 / 2);
        [self addChild:front];
        
        [self setMusic:[GameData sharedData].isMusic];
        [self setSound:[GameData sharedData].isSound];
    }
    return self;
}

- (IBAction)onPressMusic:(id)sender
{
    [GameData sharedData].isMusic = ![GameData sharedData].isMusic;
    [self setMusic:[GameData sharedData].isMusic];
}

- (IBAction)onPressSound:(id)sender
{
    [GameData sharedData].isSound = ![GameData sharedData].isSound;
    [self setSound:[GameData sharedData].isSound];
}

- (void)setMusic:(BOOL)isMusic
{
    if (isMusic) {
        [music setNormalImage:[CCSprite spriteWithFile:@"Setting_Music_On.png"]];
        [music setSelectedImage:[CCSprite spriteWithFile:@"Setting_Music_On_HL.png"]];
        if (! [[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]) {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"music-background.mp3" loop:YES];
        }
    }
    else{
        [music setNormalImage:[CCSprite spriteWithFile:@"Setting_Music_Off.png"]];
        [music setSelectedImage:[CCSprite spriteWithFile:@"Setting_Music_Off_HL.png"]];
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
    }
}

- (void)setSound:(BOOL)isSound
{
    if (isSound) {
        [sound setNormalImage:[CCSprite spriteWithFile:@"Setting_Sound_On.png"]];
        [sound setSelectedImage:[CCSprite spriteWithFile:@"Setting_Sound_On_HL.png"]];
    }
    else{
        [sound setNormalImage:[CCSprite spriteWithFile:@"Setting_Sound_Off.png"]];
        [sound setSelectedImage:[CCSprite spriteWithFile:@"Setting_Sound_Off_HL.png"]];
    }
}

- (IBAction)onPressCloseBtn:(id)sender
{
    [self removeFromParentAndCleanup:YES];
}

@end
