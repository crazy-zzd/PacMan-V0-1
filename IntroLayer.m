//
//  IntroLayer.m
//  testForCocos2d
//
//  Created by 朱 俊健 on 13-12-27.
//  Copyright 朱 俊健 2013年. All rights reserved.
//


#import "IntroLayer.h"
#import "StartLayer.h"

#pragma mark - IntroLayer

@implementation IntroLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	
	IntroLayer *layer = [IntroLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

- (id)init
{
	if( (self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
        background = [CCSprite spriteWithFile:@"Default-568h@2x.png"];
			background.rotation = 90;
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background];
        
        [self schedule:@selector(changeScene:) interval:0 repeat:NO delay:0.5];
	}
	
	return self;
}

- (void)changeScene:(ccTime)delta
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[StartLayer Scene]]];
}
@end
