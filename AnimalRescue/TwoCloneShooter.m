//
//  TwoCloneShooter.m
//  AnimalRescue
//
//  Created by iMac on 4/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TwoCloneShooter.h"


@implementation TwoCloneShooter
{
    ActionSprite *sprite, *sprite2;
}

static TwoCloneShooter *sharedTwoCloneShooterLayer;

+(TwoCloneShooter*)sharedTwoCloneShooterLayer
{
    return sharedTwoCloneShooterLayer;
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    //retain the layer
    sharedTwoCloneShooterLayer = self;
    
    sprite = [[HeroBabe alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:sprite];
    sprite.position = ccp(actionSprite.position.x, actionSprite.position.y + 25);
    sprite.isRanged = YES;
    sprite.attackRate = 1;
    sprite.normalBullet = YES;
    sprite.bulletClass = [ZapBullet class];
    sprite.bulletActionType = kbulletActionMachineGun;
    
    sprite2 = [[HeroBabe alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:sprite2];
    sprite2.position = ccp(actionSprite.position.x, actionSprite.position.y - 25);
    sprite2.isRanged = YES;
    sprite2.attackRate = 1;
    sprite2.normalBullet = YES;
    sprite2.bulletClass = [ZapBullet class];
    sprite2.bulletActionType = kbulletActionMachineGun;
    
    CCDelayTime *spriteDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *removeObject = [CCCallBlock actionWithBlock:^{
        [actionSprite.layer removeTemporaryObject:sprite];
        [actionSprite.layer removeTemporaryObject:sprite2];
    }];
    [actionSprite runAction:[CCSequence actions:spriteDuration, removeObject, nil]];
}

-(void)updatePosition:(ActionSprite *)actionSprite
{
    sprite.position = ccp(actionSprite.position.x, actionSprite.position.y + 25);
    sprite2.position = ccp(actionSprite.position.x, actionSprite.position.y - 25);
}

@end
