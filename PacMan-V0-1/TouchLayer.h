//
//  TouchLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"

#import "TouchLayerDelegate.h"

@class GameLayer;

enum tagsOfSpr {
    tagUp = 1,
    tagDown,
    tagLeft,
    tagRight
};


@interface TouchLayer : CCLayer {
    CGRect upRect,downRect,leftRect,rightRect;    
}

@property id<TouchLayerDelegate> delegate;

-(void)sendDirectionSymbole:(int)theDireciton;


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


-(CGPoint)locationFromTouches:(NSSet *)touches;

@end
