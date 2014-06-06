//
//  PlayerMan.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 13-11-10.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "PlayerMan.h"
#import "Maps.h"

#import "GameData.h"

#import "SimpleAudioEngine.h"

@implementation PlayerMan

- (id)initWithPointPosition:(CGPoint)thePointPosition withDirection:(int)theDrection
{
    if (self = [super initWithPointPosition:thePointPosition withDirection:theDrection]) {
        
        sprite = [[CCSprite alloc] initWithFile:PNG_PACMAN];
        
        sprite.flipY = NO;
        sprite.flipX = YES;
        
        //setPointPosition必须在sprite设置过以后才能正常工作
        [self setPointPosition:thePointPosition withLength:2];
        
        moveSpeed = PLAYER_SPEED;
        
        //测试动画
        [self testAnimation];
        
        score = 0;
        
        isJumping = NO;
    }
    return self;
}


- (void)eatBean
{
    score ++;
}

- (int)score
{
    return score;
}

- (BOOL)jump
{
    //如果正在跳就返回
    if (isJumping) {
        return NO;
    }
    
    //如果不能跳就返回
    CGPoint jumpPosition = [self isJumpAvailabel];
    if (CGPointEqualToPoint(jumpPosition, CGPointZero)) {
        return NO;
    }
    
    [self startJumpWithPosition:jumpPosition];

    return YES;
//    NSLog(@"我跳啦");

}

- (BOOL)isCrashedWithRect:(CGRect)theRect
{
    if (CGRectIntersectsRect(theRect, sprite.boundingBox)) {
        float distanceX = ABS(theRect.origin.x - sprite.boundingBox.origin.x);
        float distanceY = ABS(theRect.origin.y - sprite.boundingBox.origin.y);
        if ((distanceX < 1.4 * POINT_LENGTH) && (distanceY < 1.5 * POINT_LENGTH)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isContainWithRect:(CGRect)theRect
{
    if ((CGRectContainsRect(sprite.boundingBox, theRect))) {
        return YES;
    }
    return NO;
}


#pragma mark - private methods
- (void)testAnimation
{
    NSMutableArray * theTestFrames = [NSMutableArray arrayWithCapacity:4];
    for (int i = 1; i <= 4; i ++) {
        NSString * fileName = [NSString stringWithFormat:@"pac-man-%d.png",i];
        CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:fileName];
        CGSize texSize = texture.contentSize;
        CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
        
        CCSpriteFrame * frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
        [theTestFrames addObject:frame];
    }
    CCAnimation * anim = [CCAnimation animationWithSpriteFrames:theTestFrames delay:0.1f];
    
    CCAnimate * animate = [CCAnimate actionWithAnimation:anim];
    CCRepeatForever * repeat = [CCRepeatForever actionWithAction:animate];
    
    [sprite runAction:repeat];
    
}

- (void)changeSpriteDirection
{
    int theRotation = (nextDirection - nowDirection) * 90;
    if (theRotation < 0) {
        theRotation = theRotation + 360;
    }
    sprite.rotation = [sprite rotation] + theRotation;
    if (nextDirection == rightDirection) {
        sprite.flipY = NO;
    }
    else{
        sprite.flipY = YES;
    }
}


- (CGPoint)isJumpAvailabel
{
    //格子长度
    GLfloat pointLength = POINT_LENGTH;
    //地图左下角坐标
    GLfloat playViewX = [GameData sharedData].mapPosition.x;
    GLfloat playViewY = [GameData sharedData].mapPosition.y;
    //现在的位置
    CGPoint nowPosition = CGPointMake((int)[self mapPosition].x, (int)[self mapPosition].y);
    //nowDirection;
    
    //需要移动的长度
    CGPoint movement = CGPointZero;
    GLfloat moveX = 0;
    GLfloat moveY = 0;
    
//    int temp;
    switch (nowDirection) {
        case leftDirection:
            moveX = (((int)(nowPosition.x - playViewX + 1))/(int)pointLength) * pointLength - nowPosition.x - 3 * pointLength + playViewX;
            break;
        case rightDirection:
//            temp = (((int)(nowPosition.x - playViewX))/(int)pointLength) * pointLength;
            moveX = (((int)(nowPosition.x - playViewX - 1))/(int)pointLength) * pointLength + pointLength - nowPosition.x + 3 * pointLength + playViewX;
            ;
            break;
        case upDirection:
            moveY = (((int)(nowPosition.y - playViewY - 1))/(int)pointLength) * pointLength + pointLength - nowPosition.y + 3 * pointLength + playViewY;
            break;
        case downDirection:
            moveY = (((int)(nowPosition.y - playViewY + 1))/(int)pointLength) * pointLength - nowPosition.y - 3 * pointLength + playViewY;
            break;
        default:
            break;
    }
    
    movement = CGPointMake(moveX, moveY);
    
    CGPoint jumpPosition = ccpAdd(nowPosition, movement);
    
    if (![theMap isBlockedWith:jumpPosition with:length]) {
        return jumpPosition;
    }
    else{
        return CGPointZero;
    }
    
}

- (void)startJumpWithPosition:(CGPoint)jumpPosition
{
    isJumping = YES;

    CCJumpTo * jumpTo = [[CCJumpTo alloc] initWithDuration:0.3 position:jumpPosition height:5 jumps:1];
    
    
//    [self stopActionByTag:TAG_SEQUENCE];
    
    CCCallFunc * move = [CCCallFunc actionWithTarget:self selector:@selector(jumpOver)];
    
    CCSequence * sequence = [CCSequence actions:jumpTo, move, nil];
    
//    [self.sprite runAction:sequence];
    [self runSequence:sequence];

}

- (void)setDirectionAndMove:(int)theDirection
{
    if (isJumping) {
        return;
    }
    [super setDirectionAndMove:theDirection];
}

- (void)jumpOver
{
    isJumping = NO;
    
    [super setDirectionAndMove:nowDirection];
}

@end
