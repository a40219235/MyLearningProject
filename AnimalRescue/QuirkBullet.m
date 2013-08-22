//
//  QuirkBullet.m
//  AnimalRescue
//
//  Created by iMac on 4/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "QuirkBullet.h"


@implementation QuirkBullet

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer actionSprite:(ActionSprite *)actionSprite
{
    if ((self = [super initWithSpriteFrameName:@"quirk1.png" layer:layer]))
    {
        self.isAlly = isAlly;
        self.isMelee = YES;
        self.meleeDestroySelf = YES;
        self.attackRate = 1.0;
        self.isBullet = YES;
        self.alive = YES;
        self.health = 10000;
        
        self.position = actionSprite.position;
        self.attackDamage = actionSprite.attackDamage;
        self.rowPosition = actionSprite.rowPosition;
        
        //element Ability
        self.freezingAbilityEnable = actionSprite.freezingAbilityEnable;
        self.fireAbilityEnable = actionSprite.fireAbilityEnable;
        self.streakEffectEnable = actionSprite.streakEffectEnable;
        self.laserPenetrationAbility = actionSprite.laserPenetrationAbility;
        
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(-10, -4) size:CGSizeMake(20, 10)];
    }
    return self;
}

@end
