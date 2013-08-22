//
//  LaserBullet.m
//  AnimalRescue
//
//  Created by iMac on 4/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LaserBullet.h"


@implementation LaserBullet

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer actionSprite:(ActionSprite *)actionSprite
{
    if ((self = [super initWithSpriteFrameName:@"laser1.png" layer:layer]))
    {
        self.isAlly = isAlly;
        self.isMelee = YES;
        self.meleeDestroySelf = YES;
        self.attackRate = 0.05;
        self.isBullet = YES;
        self.alive = YES;
        
        self.position = actionSprite.position;
        self.attackDamage = actionSprite.attackDamage;
        self.rowPosition = actionSprite.rowPosition;
        self.rotation = actionSprite.rotation;
        
        //element Ability
        self.freezingAbilityEnable = actionSprite.freezingAbilityEnable;
        self.fireAbilityEnable = actionSprite.fireAbilityEnable;
        self.streakEffectEnable = actionSprite.streakEffectEnable;
        self.laserPenetrationAbility = actionSprite.laserPenetrationAbility;
        
        //scale for Team
        self.flipX = actionSprite.scaleX;
        
        //boomeranBullet attribute
        self.boomerangBulletInitPosition = actionSprite.position;
        self.boomerangBullet = actionSprite.boomerangBullet;
        
        
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(-15, -10) size:CGSizeMake(30, 20)];
    }
    return self;
}


@end
