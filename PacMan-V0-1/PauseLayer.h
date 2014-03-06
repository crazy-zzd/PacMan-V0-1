//
//  PauseLayer.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-12-27.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyHeader.h"

#import "PauseLayerDelegate.h"

@interface PauseLayer : CCLayer {
    
}

@property id<PauseLayerDelegate> delegate;


+ (CCScene * )Scene;

@end
