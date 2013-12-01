//
//  ControlLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-8.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum tagsOfSpr {
    tagUp = 1,
    tagDown,
    tagLeft,
    tagRight
    };


@interface ControlLayer : CCLayer {
    CGRect upRect,downRect,leftRect,rightRect;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


-(CGPoint)locationFromTouches:(NSSet *)touches;

@end
