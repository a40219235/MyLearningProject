//
//  PlayerAnimal.m
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Hero.h"
#import "CCAnimationHelper.h"


@implementation Hero

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer
{
    if ((self = [super initWithSpriteFrameName:@"hero_idle_00.png" layer:layer]))
    {
        //idle Animation
        self.idleAction = [self heroIdleDelay:0.05];
        
        //attack Animation
        self.attackAction = [self heroAttackDelay:0.05];
        
        //hurt Animation
        CCAnimation *hurtAnimation = [CCAnimation animationWithFrame:@"hero_hurt_" frameCount:3 delay:1.0/12.0];
        self.hurtAction = [CCSequence actions:[CCAnimate actionWithAnimation:hurtAnimation],[CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //knocked Out Animation
        CCAnimation *knockedOutAnimation = [CCAnimation animationWithFrame:@"hero_knockout_" frameCount:5 delay:1.0/12.0];
        self.knockedOutAction = [CCSequence actions:[CCAnimate actionWithAnimation:knockedOutAnimation],[CCFadeOut actionWithDuration:0.01], nil];
        
        self.isAlly = isAlly;
        self.alive = YES;
        
        self.scale = 0.55;
        self.health = 100;
        self.attackDamage = 10;
        self.attackRate = 2.0;
        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-32, -30) size:CGSizeMake(29 * 2, 30 * 2)];
    }
    return self;
}

-(id)walkDelay:(float)delay velocity:(float)velocity vector:(CGPoint)vector
{
    CCAnimation *walkAnimation = [CCAnimation animationWithFrame:@"hero_walk_" frameCount:8 delay:delay];
    
    CCAnimate *walkAnimate = [CCAnimate actionWithAnimation:walkAnimation];
    
    return [CCRepeatForever actionWithAction:walkAnimate];
}

//idleAction
-(id)heroIdleDelay:(float)delay
{
    CCAnimation *idleAnimation = [CCAnimation animationWithFrame:@"hero_idle_" frameCount:5 delay:1.0/24.0];
     return [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
}

//attackAction
-(id)heroAttackDelay:(float)delay
{
    CCAnimation *attackAnimation = [CCAnimation animationWithFrame:@"hero_attack_00_" frameCount:3 delay:delay];
    return [CCSequence actions:[CCAnimate actionWithAnimation:attackAnimation],[CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
}

@end
