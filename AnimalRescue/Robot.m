//
//  Robot.m
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Robot.h"
#import "CCAnimationHelper.h"

@implementation Robot

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer
{
    if ((self = [super initWithSpriteFrameName:@"robot_walk_00.png" layer:layer]))
    {
        //idle Animation
        self.idleAction = [self robotIdleDelay:0.05];
        
        //hurt Animation
        CCAnimation *hurtAnimation = [CCAnimation animationWithFrame:@"robot_hurt_" frameCount:3 delay:1.0/12.0];
        self.hurtAction = [CCSequence actions:[CCAnimate actionWithAnimation:hurtAnimation],[CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //attack Animation
        self.attackAction = [self robotAttackDelay:1.0/24.0];
        
        //knocked Out Animation
        CCAnimation *knockedOutAnimation = [CCAnimation animationWithFrame:@"robot_knockout_" frameCount:5 delay:1.0/12.0];
        self.knockedOutAction = [CCSequence actions:[CCAnimate actionWithAnimation:knockedOutAnimation],[CCFadeOut actionWithDuration:0.5], nil];
        
        self.isMelee = YES;
        
        self.alive = YES;
        self.scale = 0.55;
        self.isAlly = isAlly;
        self.health = 50;
        self.attackDamage = 5;
        self.attackRate = 5;
        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-29, -30) size:CGSizeMake(29 * 2, 30 * 2)];
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(29, -20) size:CGSizeMake(15, 20)];
    }
    return self;
}

//walkAction
-(id)walkDelay:(float)delay velocity:(float)velocity vector:(CGPoint)vector
{
    CCAnimation *walkAnimation = [CCAnimation animationWithFrame:@"robot_walk_" frameCount:6 delay:delay];
    
    CCMoveBy *moveBy= [CCMoveBy actionWithDuration:0.5 position:ccpMult(vector, velocity)];
    CCAnimate *walkAnimate = [CCAnimate actionWithAnimation:walkAnimation];
    CCSpawn *spawnAction = [CCSpawn actions:walkAnimate, moveBy, nil];
    
    CCDelayTime *delayTime = [CCDelayTime actionWithDuration:0.01];
    CCSequence *sequence = [CCSequence actions:spawnAction, delayTime, nil];
    return [CCRepeatForever actionWithAction:sequence];
}

//idleAction
-(id)robotIdleDelay:(float)delay
{
    CCAnimation *idleAnimation = [CCAnimation animationWithFrame:@"robot_idle_" frameCount:5 delay:1.0/24.0];
    return [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
}

//attackAction
-(id)robotAttackDelay:(float)delay
{
    CCAnimation *attackAnimation = [CCAnimation animationWithFrame:@"robot_attack_" frameCount:5 delay:delay];
    return [CCSequence actions:[CCAnimate actionWithAnimation:attackAnimation],[CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
}

@end