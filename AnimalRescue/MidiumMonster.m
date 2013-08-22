//
//  MidiumMonster.m
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MidiumMonster.h"
#import "LaserBullet.h"


@implementation MidiumMonster

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer actionSprite:(ActionSprite *)actionSprite
{
    if ((self = [super initWithSpriteFrameName:@"zap2.png" layer:layer]))
    {
        //idle Animation
        self.hurtAction = [CCSequence actions:[CCTintTo actionWithDuration:0.1 red:255 green:0 blue:0], [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255], nil];
        
        //knocked Out Animation
        self.knockedOutAction = [CCFadeOut actionWithDuration:1];
        
        //walk Animation
        self.walkAction = [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255];
        
        self.idleAction = [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255];
        
        self.attackAction = [CCSequence actions:[CCTintTo actionWithDuration:0.1 red:0 green:0 blue:255], [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255], nil];
        
        
        self.isAlly = isAlly;
        self.attackRate = 2 + CCRANDOM_0_1();
        self.isTracingBullet = YES;
        self.alive = YES;
        self.maxVelocity = 100;
        self.maxAcceleration = 100;
        self.health = 1;
        self.isRanged = YES;
        
        //init shooting attribute
        self.bulletClass = [LaserBullet class];
        self.bulletActionType = kbulletActionMachineGun;
        
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(-15, -10) size:CGSizeMake(30, 20)];
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-15, -10) size:CGSizeMake(30, 20)];
    }
    return self;
}

@end
