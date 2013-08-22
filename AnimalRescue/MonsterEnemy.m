//
//  MonsterEnemy.m
//  AnimalRescue
//
//  Created by iMac on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MonsterEnemy.h"


@implementation MonsterEnemy

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer
{
    if ((self = [super initWithSpriteFrameName:@"munch2.png" layer:layer]))
    {
        //idle Animation
        self.hurtAction = [CCSequence actions:[CCTintTo actionWithDuration:0.1 red:255 green:0 blue:0], [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //knocked Out Animation
        self.knockedOutAction = [CCFadeOut actionWithDuration:1];
        
        //walk Animation
        self.walkAction = [CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:3 position:ccp(self.position.x -300, self.position.y)]];
        
        self.idleAction = [CCRepeatForever actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:0.9], [CCScaleTo actionWithDuration:1 scale:1], nil]];
        
        self.attackAction = [CCSequence actions:[CCTintTo actionWithDuration:0.1 red:0 green:0 blue:255], [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        
        self.isAlly = isAlly;
        self.isMelee = YES;
        self.meleeDestroySelf = YES;
        self.attackRate = 20;
        self.alive = YES;
        self.maxVelocity = 100;
        self.maxAcceleration = 100;
        self.health = 50;
        self.isMonster = YES;
        
        //make it wait for 5 sec befor attack
        
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(-15, -10) size:CGSizeMake(30, 20)];
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-15, -10) size:CGSizeMake(30, 20)];
    }
    return self;
}


@end
