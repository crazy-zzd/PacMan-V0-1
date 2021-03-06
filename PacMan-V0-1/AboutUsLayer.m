//
//  AboutUsLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-6.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "AboutUsLayer.h"

#import "MyHeader.h"

@implementation AboutUsLayer

- (id)init
{
    self = [super init];
    if (self) {
        
//        CCSprite * transparent = [[CCSprite alloc] initWithFile:@"AboutUs_Transparent.png"];
//        transparent.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
//        [self addChild:transparent];
        
        CCSprite * background = [[CCSprite alloc] initWithFile:@"AboutUs_Background.png"];
        background.position = CGPointMake(569 / 2, SCREEN_HEIGHT - 343.5 / 2);
        [self addChild:background];
        
        CCMenuItemImage * closeBtn = [[CCMenuItemImage alloc] initWithNormalImage:@"AboutUs_Close.png" selectedImage:@"AboutUs_Close_HL.png" disabledImage:nil target:self selector:@selector(onPressCloseBtn:)];
        closeBtn.position = CGPointMake(740 / 2, 450 / 2);
        
        CCMenuItemImage * transparent = [[CCMenuItemImage alloc] initWithNormalImage:@"AboutUs_Transparent.png" selectedImage:@"AboutUs_Transparent.png" disabledImage:nil target:self selector:@selector(onPressCloseBtn:)];
        transparent.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        
        CCMenu * menu = [CCMenu menuWithItems:closeBtn, transparent, nil];
        menu.position = CGPointZero;
        [background addChild:menu];
    }
    return self;
}

- (IBAction)onPressCloseBtn:(id)sender
{
    [self removeFromParentAndCleanup:YES];
}

@end
