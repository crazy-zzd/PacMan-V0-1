//
//  ControlNodeDelegate.h
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-7.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ControlNodeDelegate <NSObject>

@required
- (void)pauseTimeLine;

- (void)resumeTimeLine;

@end
