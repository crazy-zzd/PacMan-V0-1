//
//  TouchLayerDelegate.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-15.
//  Copyright (c) 2013年 朱 俊健. All rights reserved.
//

#ifndef PacMan_V0_1_TouchLayerDelegate_h
#define PacMan_V0_1_TouchLayerDelegate_h

@protocol TouchLayerDelegate <NSObject>

@required
-(void)moveWithDirection:(int)theDirection;

- (void)playerJump;

@end

#endif
