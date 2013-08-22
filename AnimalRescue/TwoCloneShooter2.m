//
//  TwoCloneShooter2.m
//  AnimalRescue
//
//  Created by iMac on 4/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TwoCloneShooter2.h"


@implementation TwoCloneShooter2
{
    ActionSprite *sprite1, *sprite2;
}

static TwoCloneShooter2 *sharedTwoCloneShooter2Layer;

+(TwoCloneShooter2*)sharedTwoCloneShooterLayer
{
    return sharedTwoCloneShooter2Layer;
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    //retain the layer
    sharedTwoCloneShooter2Layer = self;
    
    sprite1 = [[HeroBabe alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:sprite1];
    sprite1.position = ccp(actionSprite.position.x, actionSprite.position.y + 25);
    sprite1.isRanged = YES;
    sprite1.attackRate = 1;
    sprite1.normalBullet = YES;
    
    sprite1.bulletClass = [LaserBullet class];
    sprite1.bulletActionType = kbulletActionBoomerang;
    sprite1.streakEffectEnable = YES;
    sprite1.laserPenetrationAbility = YES;
    
    sprite2 = [[HeroBabe alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:sprite2];
    sprite2.position = ccp(actionSprite.position.x, actionSprite.position.y - 25);
    sprite2.isRanged = YES;
    sprite2.attackRate = 1;
    sprite2.attackDamage = sprite2.attackDamage/2;
    
    sprite2.bulletClass = [LaserBullet class];
    sprite2.bulletActionType = kbulletActionBoomerang;
    sprite2.streakEffectEnable = YES;
    sprite2.laserPenetrationAbility = YES;
    
    //removing temporary sprites
    CCDelayTime *spriteDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *removeObject = [CCCallBlock actionWithBlock:^{
        [actionSprite.layer removeTemporaryObject:sprite1];
        [actionSprite.layer removeTemporaryObject:sprite2];
    }];
    [actionSprite runAction:[CCSequence actions:spriteDuration, removeObject, nil]];
}

-(void)updatePosition:(ActionSprite *)actionSprite
{
    sprite1.position = ccp(actionSprite.position.x, actionSprite.position.y + 25);
    sprite2.position = ccp(actionSprite.position.x, actionSprite.position.y - 25);
}

@end
